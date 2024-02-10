<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Follow extends Model
{
    use HasFactory;

    protected $fillable = [
        "follower_id",
        "following_id"
    ];

    public function follower()
    {
        return $this->belongsTo(User::class, 'follows', 'follower_id', 'users.id');
    }
    public function following()
    {
        return $this->belongsTo(User::class, 'follows', 'following_id', 'users.id')->groupBy('following_id');
    }

    public function stories(){
        return $this->hasManyThrough(Story::class, User::class, 'id', 'user_id', 'following_id', 'id');
    }

}
