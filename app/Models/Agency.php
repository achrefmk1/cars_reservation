<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Agency extends Model
{
    use HasFactory;

    protected $fillable = ['name', 'adresse', 'phone', 'email', 'workDays', 'start', 'user_id'];


    public function services()
    {
        return $this->belongsToMany(Service::class);
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
