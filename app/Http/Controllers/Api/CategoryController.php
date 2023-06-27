<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Category;
use Illuminate\Support\Facades\Validator;


class CategoryController extends Controller
{
    public function addCategory(Request $request)
    {
        try {
            $request->validate([
                'user_id' => 'required',
                'category_name' => 'required',
                'slug' => 'required',
                'category_image' => 'image|mimes:jpeg,png,jpg,gif|max:2048',
            ]);

            $user = auth()->user();
            if ($user->role->role === 'admin') {

                $categoryData = $request->only([
                    'user_id',
                    'category_name',
                    'slug',
                    'category_type',
                    'category_content',
                    'category_specification'
                ]);

                if ($request->hasFile('category_image')) {
                    $image = $request->file('category_image');
                    $imageName = time() . '_' . $image->getClientOriginalName();
                    $image->storeAs('public/categories', $imageName);

                    // Append the image URL to the product data
                    $categoryData['category_image'] = asset('storage/categories/' . $imageName);
                }

                $category = Category::create($categoryData);

                if ($category) {
                    $response = [
                        'data' => $category,
                        'message' => 'category added successfully',
                        'success' => true,
                    ];
                }
                return response()->json($response, 201);
            } else {
                $response = [
                    'data' => null,
                    'message' => 'You are not authorized to create a category',
                    'success' => false,
                ];
                return response()->json($response, 403);
            }
        } catch (\Throwable $th) {

            $errors = $th->getMessage();
            return response([
                'data' => null,
                'message' => $errors,
                'success' => false,
            ]);
        }
    }

    public function getCategories()
    {
        $user = auth()->user();
        if ($user->role->role === 'admin') {

            $categories = Category::all();

            return response()->json([
                'data' => $categories,
                'message' => 'Categories retrieved successfully',
                'success' => true,
            ], 200);
        } else {
            $response = [
                'data' => null,
                'message' => 'You are not authorized to create a category',
                'success' => false,
            ];
            return response()->json($response, 403);
        }
    }

    public function getCategory($id)

    {

        $user = auth()->user();
        if ($user->role->role === 'admin') {

            $category = Category::find($id);

            if (!$category) {
                return response()->json([
                    'data' => null,
                    'message' => 'Category not found',
                    'success' => false,
                ], 404);
            }

            return response()->json([
                'data' => $category,
                'message' => 'Category retrieved successfully',
                'success' => true,
            ], 200);
        } else {
            $response = [
                'data' => null,
                'message' => 'You are not authorized to create a category',
                'success' => false,
            ];
            return response()->json($response, 403);
        }
    }


    public function updateCategory(Request $request, $id)
    {
        try {

            $user = auth()->user();
            if ($user->role->role === 'admin') {
                $category = Category::find($id);

                if (!$category) {
                    return response()->json([
                        'data' => null,
                        'message' => 'Category not found',
                        'success' => false,
                    ], 404);
                }

                $validator = Validator::make($request->all(), [
                    'category_name' => 'required',
                    'slug' => 'required',
                    'category_image' => 'image|mimes:jpeg,png,jpg,gif|max:2048',
                ]);

                if ($validator->fails()) {
                    return response()->json([
                        'data' => null,
                        'message' => $validator->errors()->first(),
                        'success' => false,
                    ], 400);
                }

                $category->user_id = $request->input('user_id');
                $category->category_name = $request->input('category_name');
                $category->slug = $request->input('slug');
                $category->category_type = $request->input('category_type');
                $category->category_content = $request->input('category_content');
                $category->category_specification = $request->input('category_specification');

                if ($request->hasFile('category_image')) {
                    $image = $request->file('category_image');
                    $imageName = time() . '_' . $image->getClientOriginalName();
                    $image->storeAs('public/categories', $imageName);
                    $category->category_image = asset('storage/categories/' . $imageName);
                }

                $category->save();

                return response()->json([
                    'data' => $category,
                    'message' => 'Category updated successfully',
                    'success' => true,
                ], 200);
            } else {
                $response = [
                    'data' => null,
                    'message' => 'You are not authorized to create a category',
                    'success' => false,
                ];
                return response()->json($response, 403);
            }
        } catch (\Throwable $th) {
            $errors = $th->getMessage();
            return response()->json([
                'data' => null,
                'message' => $errors,
                'success' => false,
            ], 500);
        }
    }

    public function deleteCategory($id)
    {
        try {

            $user = auth()->user();
            if ($user->role->role === 'admin') {
                $category = Category::find($id);

                if (!$category) {
                    return response()->json([
                        'data' => null,
                        'message' => 'Category not found',
                        'success' => false,
                    ], 404);
                }

                $category->delete();

                return response()->json([
                    'data' => null,
                    'message' => 'Category deleted successfully',
                    'success' => true,
                ], 200);
            } else {
                $response = [
                    'data' => null,
                    'message' => 'You are not authorized to create a category',
                    'success' => false,
                ];
                return response()->json($response, 403);
            }
        } catch (\Throwable $th) {
            $errors = $th->getMessage();
            return response()->json([
                'data' => null,
                'message' => $errors,
                'success' => false,
            ], 500);
        }
    }
}
