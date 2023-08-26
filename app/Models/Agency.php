<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Agency extends Model
{
    use HasFactory;

    protected $fillable = ['name', 'adresse', 'phone', 'email', 'workDays', 'start', 'end', 'user_id'];


    public function services()
    {
        return $this->hasMany(Service::class);
    }

    public function days()
    {
        return $this->hasMany(DayOff::class);
    }

    /**
     * Get the user that owns the Agency
     *
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
