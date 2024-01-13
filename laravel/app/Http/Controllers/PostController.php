<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;

use Illuminate\Http\Request;
use App\Models\User;
use App\Models\Post;

class PostController extends Controller
{
    //get all posts
    public function all()
    {
        $posts = Post::with('categoryTech:name,description,image')->withCount('comments', 'likes')->get();
        return response([
            'posts' => $posts
        ], 200);
    }

    public function one($id)
    {      
        //get with user, categoryTech, comments and likes
        $posts = Post::with('user:id,name,email', 'categoryTech:name,description,image', 'comments', 'likes')->find($id);
        return response([
            'post' => $posts
        ], 200);
    }

    public function create(Request $request)
    {
        //validate fields
        $attrs = $request->validate([
            'body' => 'required|string'
        ]);

        $image = $this->saveImage($request->image, 'posts');

        $post = new Post();
        $post->body = $attrs['body'];
        $post->title = $request->title;
        $post->user_id = auth()->user()->id;
        $post->image = $image;
        $post->category_tech_id = $request->category_tech_id;
        $post->save();
        
        return response([
            'message' => 'Post created.',
            'post' => $post
        ], 200);
    }

    public function update(Request $request, $id)
    {

        $post = Post::find($id);

        if(!$post)
        {
            return response([
                'message' => 'Post not found.'
            ], 403);
        }

        if($post->user_id != auth()->user()->id)
        {
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

        if(!$post)
        {
            return response([
                'message' => 'Post not found.'
            ], 403);
        }

        if($post->user_id != auth()->user()->id)
        {
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
