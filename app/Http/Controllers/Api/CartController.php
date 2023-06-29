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
    public function createCartAndItem(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'user_id' => 'required',
            'product_id' => 'required',
            'quantity' => 'required|integer|min:1',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'data' => null,
                'message' => $validator->errors()->first(),
                'success' => false,
            ], 400);
        }

        try {
            $user = User::find($request->user_id);
            $product = Product::find($request->product_id);

            if (!$user || !$product) {
                return response()->json([
                    'data' => null,
                    'message' => 'User or product not found',
                    'success' => false,
                ], 404);
            }

            $cart = Cart::create([
                'user_id' => $user->id,
                'total' => 0,
                'subtotal' => 0,
            ]);

            $item = CartItem::create([
                'cart_id' => $cart->id,
                'product_id' => $product->id,
                'quantity' => $request->quantity,
                'price' => $product->price,
            ]);

            // Calculate the subtotal and update the cart
            $subtotal = $item->quantity * $item->price;
            $cart->subtotal = $subtotal;
            $cart->total = $subtotal;
            $cart->save();

            // Handle quantity > 1
            if ($item->quantity > 1) {
                $item->price = $product->price * $item->quantity;
                $item->save();

                $cart->total += $item->price - $subtotal;
                $cart->subtotal = $item->price;
                $cart->save();
            }

            return response()->json([
                'data' => $cart,
                'message' => 'Cart created successfully',
                'success' => true,
            ], 201);
        } catch (\Throwable $th) {
            $errors = $th->getMessage();
            return response()->json([
                'data' => null,
                'message' => $errors,
                'success' => false,
            ], 500);
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

    public function getCart(Request $request, $cartId)
    {
        $user = auth()->user();
        $cart = Cart::with('cartItems.product')->findOrFail($cartId);

        return response()->json([
            'data' => $cart,
            'message' => 'Cart retrieved successfully',
            'success' => true,
        ], 200);
    }

    public function deleteCart(Request $request, $id)
    {
        $user = auth()->user();
        $cartItem = Cart::findOrFail($id);
        $cart = $cartItem->cart;

        // Delete the cart item
        $cartItem->delete();

        // Update cart subtotal and total
        // $cart->updateSubtotal();
        // $cart->updateTotal();

        return response()->json([
            'data' => null,
            'message' => 'Item removed from cart successfully',
            'success' => true,
        ], 200);
    }
}
