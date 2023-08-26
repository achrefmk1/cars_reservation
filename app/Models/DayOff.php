<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DayOff extends Model
{
    use HasFactory;

    protected $fillable = ['name', 'date', 'agency_id'];

    public function agency()
    {
        return $this->belongsTo(Agency::class);
    }
}
