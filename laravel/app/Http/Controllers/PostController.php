<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;

use Illuminate\Http\Request;
use App\Models\User;
use App\Models\Post;
use Illuminate\Support\Facades\Log;

class PostController extends Controller
{
    //get all posts
    public function all(Request $request)
    {
        $categoryId = $request->input('category_id');
        $userId = $request->input('user_id');

        $query = Post::with('categoryTech:name,description,image', 'user')->withCount('comments', 'likes');

        if ($categoryId !== null) {
            $query->where('category_tech_id', $categoryId);
        }
        else if ($userId !== null) {
            $query->where('user_id', $userId);
        }

        $posts = $query->get();
        Log::info($posts);        
        return response()->json(
            [
                'posts' => $posts,
            ],
            200
        );
    }

    public function one($id)
    {
        $posts = Post::with('user:id,name,email', 'categoryTech:name,description,image', 'comments', 'likes')->find($id);
        return response([
            'post' => $posts
        ], 200);
    }

    public function create(Request $request)
    {
        //$image = $this->saveImage($attrs['image'], 'posts');
        $attrs = $request['post'];
        Log::info($attrs);
        $post = new Post();
        $post->body = $attrs['body'];
        $post->title = $attrs['title'];
        $post->user_id = auth()->user()->id;

        $image = $this->saveImage($request->image, 'profiles');
        $post->image = $image;
        $post->save();

        return response([
            'message' => 'Post created.',
            'post' => $post
        ], 200);
    }

    public function update(Request $request, $id)
    {

        $post = Post::find($id);

        if (!$post) {
            return response([
                'message' => 'Post not found.'
            ], 403);
        }

        if ($post->user_id != auth()->user()->id) {
            return response([
                'message' => 'Permission denied.'
            ], 403);
        }

        //validate fields
        $attrs = $request->validate([
            'body' => 'required|string'
        ]);

        $image = $this->saveImage($request->image, 'posts');
        $post->body = $attrs['body'];
        $post->title = $request->title;
        $post->image = $image;
        $post->category_tech_id = $request->category_tech_id;
        $post->save();

        return response([
            'message' => 'Post updated.',
            'post' => $post
        ], 200);
    }
    public function delete($id)
    {
        $post = Post::find($id);

        if (!$post) {
            return response([
                'message' => 'Post not found.'
            ], 403);
        }

        if ($post->user_id != auth()->user()->id) {
            return response([
                'message' => 'Permission denied.'
            ], 403);
        }

        $post->delete();

        return response([
            'message' => 'Post updated.'
        ], 200);
    }
}
