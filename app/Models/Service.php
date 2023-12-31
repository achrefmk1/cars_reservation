<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Service extends Model
{
    use HasFactory;

    protected $table = "agency_service";

    protected $fillable = ['service', 'period', "times"];


    public function agency()
    {
        return $this->belongsTo(Agency::class);
    }
}
