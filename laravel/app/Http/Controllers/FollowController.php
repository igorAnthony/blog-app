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
            'message' => 'Follow created.',
            'follow' => $follow
        ], 200);
    }
    public function unfollow(Request $request)
    {
        $follow = Follow::where('follower_id', auth()->user()->id)->where('following_id', $request->following_id)->first();
        $follow->delete();

        return response([
            'message' => 'Follow deleted.',
            'follow' => $follow
        ], 200);
    }
    public function followers()
    {
        return response([
            'followers' => auth()->user()->followers()->with('user:id,name,image')->get()
        ], 200);
    }
    public function followings()
    {
        return response([
            'followings' => auth()->user()->followings()->with('user:id,name,image')->get()
        ], 200);
    }
}
