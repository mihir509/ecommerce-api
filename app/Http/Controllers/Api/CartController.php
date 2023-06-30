<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Product;
use App\Models\Cart;
use App\Models\CartItem;
use App\Models\User;
use Illuminate\Support\Facades\Validator;




class CartController extends Controller
{


    public function addToCart(Request $request)
    {
        try {
            $request->validate([
                'user_id' => 'required',
                'product_id' => 'required',
                'quantity' => 'required|integer|min:1',
            ]);
    
            $user = auth()->user();
            $cart = Cart::where('user_id', $request->user_id)->first();
    
            if (!$cart) {
                $cart = Cart::create(['user_id' => $request->user_id]);
            }
    
            $product = Product::findOrFail($request->product_id);
    
            $cartItem = CartItem::where('cart_id', $cart->id)
                ->where('product_id', $product->id)
                ->first();
    
            if ($cartItem) {
                $cartItem->quantity += $request->quantity;
                $cartItem->save();
            } else {
                $cartItem = new CartItem([
                    'cart_id' => $cart->id,
                    'product_id' => $product->id,
                    'quantity' => $request->quantity,
                    'price' => $product->price,
                ]);
                $cartItem->save();
            }
    
            $cart->updateTotals();
    
            return response()->json([
                'data' => $cart,
                'message' => 'Product added to cart successfully',  
                'success' => true,
            ], 200);
        } catch (\Throwable $th) {

            $errors = $th->getMessage();
            return response()->json([
                'data' => null,
                'message' => $errors,  
                'success' => false,
            ], 400);
        }
    }

    public function getallCarts(Request $request)
    {
        $user = auth()->user();
        $carts = Cart::with('cartItems.product')->where('user_id', $user->id)->get();

        return response()->json([
            'data' => $carts,
            'message' => 'Carts list retrieved successfully',
            'success' => true,
        ], 200);
    }

    public function retrieveCart(Request $request, $id)
    {
        try {
            $user = auth()->user();
            $cart = Cart::with('cartItems.product')->where('user_id', $user->id)->findOrFail($id);
    
            return response()->json([
                'data' => $cart,
                'message' => 'Cart retrieved successfully',
                'success' => true,
            ], 200);
        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            return response()->json([
                'data' => null,
                'message' => 'Cart not found',
                'success' => false,
            ], 404);
        } catch (\Exception $e) {
            return response()->json([
                'data' => null,
                'message' => 'Failed to retrieve cart',
                'success' => false,
            ], 500);
        }
    }
    

    public function deleteCart(Request $request, $id)
    {
        try {
            //code...
            $user = auth()->user();
            $cart = Cart::findOrFail($id);
            // Delete the cart items
            $cart->cartItems()->delete();
        
            // Delete the cart
            $cart->delete();
        
            return response()->json([
                'data' => null,
                'message' => 'Cart deleted successfully',
                'success' => true,
            ], 200);
        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            return response()->json([
                'data' => null,
                'message' => 'Cart not found',
                'success' => false,
            ], 404);
        } catch (\Exception $e) {
            return response()->json([
                'data' => null,
                'message' => 'Failed to delete cart',
                'success' => false,
            ], 500);
        }
    }
    
}
