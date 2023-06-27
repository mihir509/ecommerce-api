<?php

namespace App\Http\Controllers\Api\products;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Product;
use Illuminate\Support\Facades\Storage;

class ProductController extends Controller
{
    public function addProduct(Request $request)
    {
        try {
            $request->validate([
                'user_id' => 'required',
                'product_name' => 'required',
                'product_category' => 'required',
                'sub_category' => 'required',
                'product_sku' => 'required',
                'price' => 'required',
                'slug' => 'required',
                'stock' => 'required',
                'long_description' => 'required',
                'short_description' => 'required',
                'product_specification' => 'required',
                'product_image_1' => 'image|mimes:jpeg,png,jpg,gif|max:2048',
            ]);

            $user = auth()->user();
            if ($user->role->role === 'admin') {

                $productData = $request->only([
                    'user_id',
                    'product_name',
                    'product_category',
                    'sub_category',
                    'product_sku',
                    'price',
                    'slug',
                    'stock',
                    'long_description',
                    'short_description',
                    'product_specification',
                ]);
                $productImages = [];
                $imageFields = ['product_image_1', 'product_image_2', 'product_image_3', 'product_image_4', 'product_image_5'];
                foreach ($imageFields as $field) {
                    if ($request->hasFile($field)) {
                        $image = $request->file($field);
                        $imageName = time() . '_' . $image->getClientOriginalName();
                        $image->storeAs('public/products', $imageName);
                        $productImages[$field] = asset('storage/products/' . $imageName);
                    }
                }
                $productData = array_merge($productData, $productImages);
                $product = Product::create($productData);
                if ($product) {
                    $response = [
                        'data' => $product,
                        'message' => 'Product added successfully',
                        'success' => true,
                    ];
                }
                return response()->json($response, 201);
            } else {
                $response = [
                    'data' => null,
                    'message' => 'You are not authorized to create a product',
                    'success' => false,
                ];
                return response()->json($response, 403);
            }
        } catch (\Throwable $th) {
            $errors = $th->getMessage();
            $response = [
                'data' => null,
                'message' => $errors,
                'success' => false,
            ];
            return response()->json($response, 400);
        }
    }
}
