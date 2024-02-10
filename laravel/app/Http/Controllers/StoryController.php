<?php

namespace App\Http\Controllers;

use App\Models\Follow;
use App\Models\Story;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

class StoryController extends Controller
{
    public function all()
    {
        $user = auth()->user();

        $stories = Follow::with('stories')
            ->leftJoin('users', 'follows.following_id', '=', 'users.id')
            ->where('follower_id', $user->id)->get();

        
        //add user autenticate stories
        $authUserStories = User::with('stories')
            ->find($user->id);
        $data = new \stdClass();
        $data->friends = $stories->values();

        $data->current_user_stories = $authUserStories->stories;

        return response([
            'stories' => $data
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
