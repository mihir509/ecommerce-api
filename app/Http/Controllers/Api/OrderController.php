<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Order;
use App\Models\Cart;
use App\Models\CartItem;
use App\Models\OrderItem;


class OrderController extends Controller
{
    public function createOrder(Request $request)
    {
        try {
            //code...
            $user = auth()->user();
            $cart = Cart::with('cartItems.product')->where('user_id', $user->id)->first();
            // Create the order
            $order = Order::create([
                'user_id' => $user->id,
                'status' => $request->status,
                'payment_status' => $request->payment_status,
                'total' => $cart->total, // Assuming you have a 'total' column in the orders table
            ]);
    
            // Create order items from cart items
            foreach ($cart->cartItems as $cartItem) {
                $product = $cartItem->product;
                $price = $product->price * $cartItem->quantity;
    
                OrderItem::create([
                    'order_id' => $order->id,
                    'product_id' => $product->id,
                    'quantity' => $cartItem->quantity,
                    'price' => $price,
                ]);
            }
    
            // Clear the cart after creating the order
            $cart->cartItems()->delete();
            $cart->update(['total' => 0]);
    
            return response()->json([
                'data' => $order,
                'message' => 'Order created successfully',
                'success' => true,
            ], 201);
        } catch (\Throwable $th) {
            //throw $th;
            $errors = $th->getMessage();
            return response()->json([
                'data' => null,
                'message' => $errors,
                'success' => false,
            ], 400);
        }
    }

    public function getOrder($id)
    {

        try {
            //code...
            $order = Order::with('orderItems')->find($id);
    
            if (!$order) {
                return response()->json([
                    'message' => 'Order not found',
                    'success' => false,
                ], 404);
            }
    
            return response()->json([
                'data' => $order,
                'message' => 'Order retrieved successfully',
                'success' => true,
            ], 200);
        } catch (\Throwable $th) {
            //throw $th;
            $errors = $th->getMessage();
            return response()->json([
                'data' => null,
                'message' => $errors,
                'success' => false,
            ], 400);
            
        }
    }


    public function getallOrders()
    {

        try {
            //code...
            $order = Order::with('orderItems')->get();
    
            if (!$order) {
                return response()->json([
                    'message' => 'Order not found',
                    'success' => false,
                ], 404);
            }
    
            return response()->json([
                'data' => $order,
                'message' => 'Order retrieved successfully',
                'success' => true,
            ], 200);
        } catch (\Throwable $th) {
            //throw $th;
            $errors = $th->getMessage();
            return response()->json([
                'data' => null,
                'message' => $errors,
                'success' => false,
            ], 400);
            
        }
    }

    public function updateOrder(Request $request, $id)
    {
        try {
            $order = Order::findOrFail($id);
    
            // Update order fields
            $order->status = $request->status;
            $order->payment_status = $request->payment_status;
            // Update other order fields as needed
            $order->save();
            // Update order items
    
            return response()->json([
                'data' => $order,
                'message' => 'Order updated successfully',
                'success' => true,
            ], 200);
            
        } catch (\Throwable $th) {
            //throw $th;
            $errors = $th->getMessage();
            return response()->json([
                'data' => null,
                'message' => $errors,
                'success' => false,
            ], 400);
        }
    }
}
