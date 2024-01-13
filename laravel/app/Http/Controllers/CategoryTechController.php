<?php

namespace App\Http\Controllers;

use App\Models\CategoryTech;
use Illuminate\Http\Request;

class CategoryTechController extends Controller
{
    public function one($id)
    {
        return response([
            'story' => CategoryTech::where('id', $id)->get()
        ], 200);
    }
    public function all(){
        return response([
            'stories' => CategoryTech::orderBy('created_at', 'desc')->get()
        ], 200);
    } 
}
