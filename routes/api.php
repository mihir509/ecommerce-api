<?php
use App\Http\Controllers\Api\users\LoginController;
use App\Http\Controllers\Api\users\RegisterController;
use App\Http\Controllers\Api\users\ForgotpasswordController;
use App\Http\Controllers\Api\ProductController;
use App\Http\Controllers\Api\CategoryController;
use App\Http\Controllers\Api\SubCategoryController;
use App\Http\Controllers\Api\CartController;



use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

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

Route::post('/login', [LoginController::class, 'login']);
Route::post('/register', [RegisterController::class, 'register']);
Route::post('/forgot-password', [ForgotpasswordController::class, 'forgotPassword']);
Route::post('/verify-token', [ForgotpasswordController::class, 'verifyToken']);
Route::post('/reset-password', [ForgotpasswordController::class, 'resetPassword']);




Route::middleware('auth:sanctum')->group(function () {
    Route::get('/user', function (Request $request) {
        return $request->user();
    });

    Route::post('/change-password', [ForgotpasswordController::class, 'changePassword']);

    // product
    Route::post('/admin/product', [ProductController::class, 'addProduct']);
    Route::get('/admin/products', [ProductController::class, 'getProducts']);
    Route::get('/admin/product/{id}', [ProductController::class, 'getProduct']);
    Route::patch('/admin/product/{id}', [ProductController::class, 'updateProduct']);
    Route::delete('/admin/product/{id}', [ProductController::class, 'deleteProduct']);

    //category
    Route::post('/admin/category', [CategoryController::class, 'addCategory']);
    Route::get('/admin/categories', [CategoryController::class, 'getCategories']);
    Route::get('/admin/category/{id}', [CategoryController::class, 'getCategory']);
    Route::patch('/admin/category/{id}', [CategoryController::class, 'updateCategory']);
    Route::delete('/admin/category/{id}', [CategoryController::class, 'deleteCategory']);

    Route::post('/admin/sub-category', [SubCategoryController::class, 'addSubCategory']);
    Route::get('/admin/sub-categories', [SubCategoryController::class, 'getSubCategories']);
    Route::get('/admin/sub-category/{id}', [SubCategoryController::class, 'getSubCategory']);
    Route::patch('/admin/sub-category/{id}', [SubCategoryController::class, 'updateSubCategory']);
    Route::delete('/admin/sub-category/{id}', [SubCategoryController::class, 'deleteSubCategory']);

    Route::post('/cart/add', [CartController::class, 'addToCart']);
    Route::get('/cartslist', [CartController::class, 'getallCarts']);
    Route::get('/cart/{id}', [CartController::class, 'retrieveCart']);
    Route::delete('/cart/{id}', [CartController::class, 'deleteCart']);

});

