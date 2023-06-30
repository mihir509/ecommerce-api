<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\CartItem;
use Illuminate\Support\Facades\DB;


class Cart extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id',
        'total',
        'subtotal',
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function cartItems()
    {
        return $this->hasMany(CartItem::class);
    }

    public function updateTotals()
    {
        $subtotal = $this->cartItems()
            ->select(DB::raw('SUM(quantity * price) as subtotal'))
            ->value('subtotal');

        $this->subtotal = $subtotal;
        $this->total = $subtotal; // Assuming total is initially the same as subtotal
        $this->save();
    }

    
}
