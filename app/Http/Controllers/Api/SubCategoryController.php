<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\SubCategory;
use Illuminate\Support\Facades\Validator;


class SubCategoryController extends Controller
{
    
    public function addSubCategory(Request $request)
    {
        try {
            $request->validate([
                'user_id' => 'required',
                'sub_category_name' => 'required',
                'slug' => 'required',
                'sub_category_image' => 'image|mimes:jpeg,png,jpg,gif|max:2048',
            ]);

            $user = auth()->user();
            if ($user->role->role === 'admin') {

                $subcategoryData = $request->only([
                    'user_id',
                    'category_id',
                    'sub_category_name',
                    'slug',
                    'sub_category_type',
                    'sub_category_content',
                    'sub_category_specification'
                ]);

                if ($request->hasFile('sub_category_image')) {
                    $image = $request->file('sub_category_image');
                    $imageName = time() . '_' . $image->getClientOriginalName();
                    $image->storeAs('public/subcategories', $imageName);

                    // Append the image URL to the product data
                    $subcategoryData['sub_category_image'] = asset('storage/subcategories/' . $imageName);
                }

                $subcategory = SubCategory::create($subcategoryData);

                if ($subcategory) {
                    $response = [
                        'data' => $subcategory,
                        'message' => 'Sub category added successfully',
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

    public function getSubCategories()
    {
        $user = auth()->user();
        if ($user->role->role === 'admin') {

            $categories = SubCategory::all();

            return response()->json([
                'data' => $categories,
                'message' => 'SubCategories retrieved successfully',
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
    public function getSubCategory($id)

    {

        $user = auth()->user();
        if ($user->role->role === 'admin') {

            $subctegory = SubCategory::find($id);

            if (!$subctegory) {
                return response()->json([
                    'data' => null,
                    'message' => 'SubCategory not found',
                    'success' => false,
                ], 404);
            }

            return response()->json([
                'data' => $subctegory,
                'message' => 'SubCategory retrieved successfully',
                'success' => true,
            ], 200);
        } else {
            $response = [
                'data' => null,
                'message' => 'You are not authorized to create a subcategory',
                'success' => false,
            ];
            return response()->json($response, 403);
        }
    }

    public function updateSubCategory(Request $request, $id)
    {
        try {

            $user = auth()->user();
            if ($user->role->role === 'admin') {
                $subcategory = SubCategory::find($id);

                if (!$subcategory) {
                    return response()->json([
                        'data' => null,
                        'message' => 'subCategory not found',
                        'success' => false,
                    ], 404);
                }

                $validator = Validator::make($request->all(), [
                    'sub_category_name' => 'required',
                    'slug' => 'required',
                    'sub_category_image' => 'image|mimes:jpeg,png,jpg,gif|max:2048',
                ]);

                if ($validator->fails()) {
                    return response()->json([
                        'data' => null,
                        'message' => $validator->errors()->first(),
                        'success' => false,
                    ], 400);
                }

                $subcategory->user_id = $request->input('user_id');
                $subcategory->category_id = $request->input('category_id');
                $subcategory->sub_category_name = $request->input('sub_category_name');
                $subcategory->slug = $request->input('slug');
                $subcategory->sub_category_type = $request->input('sub_category_type');
                $subcategory->sub_category_content = $request->input('sub_category_content');
                $subcategory->sub_category_specification = $request->input('sub_category_specification');

                if ($request->hasFile('sub_category_image')) {
                    $image = $request->file('sub_category_image');
                    $imageName = time() . '_' . $image->getClientOriginalName();
                    $image->storeAs('public/categories', $imageName);
                    $subcategory->sub_category_image = asset('storage/subcategories/' . $imageName);
                }

                $subcategory->save();

                return response()->json([
                    'data' => $subcategory,
                    'message' => 'SubCategory updated successfully',
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

    public function deleteSubCategory($id)
    {
        try {

            $user = auth()->user();
            if ($user->role->role === 'admin') {
                $subctegory = subCategory::find($id);

                if (!$subctegory) {
                    return response()->json([
                        'data' => null,
                        'message' => 'SubCategory not found',
                        'success' => false,
                    ], 404);
                }

                $subctegory->delete();

                return response()->json([
                    'data' => null,
                    'message' => 'SubCategory deleted successfully',
                    'success' => true,
                ], 200);
            } else {
                $response = [
                    'data' => null,
                    'message' => 'You are not authorized to create a subcategory',
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
