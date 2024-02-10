<?php

namespace App\Http\Controllers;

use App\Models\Follow;
use Illuminate\Http\Request;

class FollowController extends Controller
{
    public function follow(Request $request)
    {
        $follow = new Follow();
        $follow->follower_id = auth()->user()->id;
        $follow->following_id = $request->following_id;
        $follow->save();

        return response([
            'message' => 'Followed.',
            'follow' => $follow
        ], 200);
    }
    public function unfollow(Request $request)
    {
        $follow = Follow::where('follower_id', auth()->user()->id)->where('following_id', $request->following_id)->first();
        $follow->delete();

        return response([
            'message' => 'Unfollowed.',
            'follow' => $follow
        ], 200);
    }    
}
