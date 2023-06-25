<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class SubCategory extends Model
{
    use HasFactory;

    protected $fillable = [
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
