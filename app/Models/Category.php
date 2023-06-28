<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\SubCategory;
use App\Models\Product;


class Category extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id',
        'category_name',
        'category_type',
        'slug',
        'category_image',
        'category_content',
        'category_specification'
    ];

    public function subcategories()
    {
        return $this->hasMany(Subcategory::class);
    }
    
    public function product()
    {
        return $this->hasMany(Product::class);
    }
}
