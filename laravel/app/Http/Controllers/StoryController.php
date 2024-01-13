<?php

namespace App\Http\Controllers;

use App\Models\Story;
use Illuminate\Http\Request;

class StoryController extends Controller
{
    public function one($id)
    {
        return response([
            'story' => Story::where('id', $id)->with('user:id,name,image')->get()
        ], 200);
    }

    public function all()
    {
        return response([
            'stories' => Story::orderBy('created_at', 'desc')->with('user:id,name,image')->get()
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
