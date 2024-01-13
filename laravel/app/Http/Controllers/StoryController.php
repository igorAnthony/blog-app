<?php

namespace App\Http\Controllers;

use App\Models\Story;
use Illuminate\Http\Request;

class StoryController extends Controller
{
    public function one($id)
    {
        $story = Story::with('user:id,name,image')->find($id);
        
        return response([
            'story' => $story
        ], 200);
    }

    public function all()
    {
        //apenas pegue story apenas de quem o usuario segue de duração de no maximo de 24 horas e ordene por data de criação, traga o usuario que criou o story
        $stories = Story::whereHas('user.followers', function ($q) {
            $q->where('follower_id', auth()->user()->id);
        })->where('created_at', '>=', now()->subHours(24))->with('user:id,name,image')->orderBy('created_at', 'desc')->get();

        return response([
            'stories' => $stories
        ], 200);
    }
    public function delete($id)
    {
        $story = Story::find($id);

        if (!$story) {
            return response([
                'message' => 'Story not found.'
            ], 404);
        }

        $story->delete();

        return response([
            'message' => 'Story deleted.'
        ], 200);
    }
    public function create(Request $request)
    {
        $attrs = $request->validate([
            'image' => 'required|image'
        ]);

        $image = $this->saveImage($request->image, 'stories');

        $story = new Story();
        $story->user_id = auth()->user()->id;
        $story->image = $image;
        $story->save();

        return response([
            'message' => 'Story created.',
            'story' => $story
        ], 200);
    }
}
