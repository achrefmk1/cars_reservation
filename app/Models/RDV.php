<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class RDV extends Model
{
    use HasFactory;

    protected $table = "rdv";

    protected $fillable = ['agency_id', 'service', 'car_id', 'date', 'start', 'end'];

    /**
     * Get the agency that owns the RDV
     *
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function agency()
    {
        return $this->belongsTo(Agency::class, 'agency_id');
    }

    public function car()
    {
        return $this->belongsTo(Car::class, 'car_id');
    }
}
