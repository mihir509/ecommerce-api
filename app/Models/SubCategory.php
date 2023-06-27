<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Category;

class SubCategory extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id',
        'category_id',
        'sub_category_name',
        'sub_category_type',
        'slug',
        'sub_category_image',
        'sub_category_content',
        'sub_category_specification'
    ];

    public function category()
    {
        return $this->belongsTo(Category::class);
    }
}
