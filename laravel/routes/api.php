<?php

use App\Http\Controllers\StoryController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\PostController;
use App\Http\Controllers\CommentController;
use App\Http\Controllers\LikeController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::post('/register',[AuthController::class, 'register']);
Route::post('/login',[AuthController::class, 'login']);

//protected routes
Route::group(['middleware' => ['auth:sanctum']], function(){

    //user
    Route::get('/user', [AuthController::class, 'user']);
    Route::put('/user', [AuthController::class, 'update']);
    Route::post('/logout', [AuthController::class, 'logout']);

    //post
    Route::get('/posts', [PostController::class, 'all']); //all posts
    Route::post('/posts', [PostController::class, 'create']); //create post
    Route::get('/posts/{id}', [PostController::class, 'one']); //get single post
    Route::put('/posts/{id}', [PostController::class, 'update']); //update post
    Route::delete('/posts/{id}', [PostController::class, 'delete']); //delete post

    //comment
    Route::get('/posts/{id}/comments', [CommentController::class, 'one']); //all comments of post
    Route::post('/posts/{id}/comments', [CommentController::class, 'create']); //create comment on a post
    Route::put('/comments/{id}', [CommentController::class, 'update']); //update a comment
    Route::delete('/comments/{id}', [CommentController::class, 'delete']); // delete a comment

    //like
    Route::post('/posts/{id}/likes', [LikeController::class, 'likeOrUnlike']); //create comment on a post

    //story
    Route::get('/stories', [StoryController::class, 'all']); //all stories
    Route::get('/stories/{id}', [StoryController::class, 'one']); //get single story
    Route::post('/stories', [StoryController::class, 'createStory']); //create story
    Route::delete('/stories/{id}', [StoryController::class, 'delete']); //delete story


});