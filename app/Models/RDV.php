<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class RDV extends Model
{
    use HasFactory;

    protected $table = "rdv";

    protected $fillable = ['agency_id', 'service', 'car_id', 'date'];
}
