<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\User;
use App\Models\Category;
use App\Models\SubCategory;



class Product extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id',
        'category_id',
        'sub_category_id',
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
        'product_image_1',
        'product_image_2',
        'product_image_3',
        'product_image_4',
        'product_image_5',
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function category()
    {
        return $this->belongsTo(Category::class,  'category_id');
    }

    public function subcategories()
    {
        return $this->belongsTo(SubCategory::class,  'sub_category_id');
    }
}
