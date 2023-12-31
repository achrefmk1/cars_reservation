<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('rdv', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('agency_id');
            $table->string('service');
            $table->unsignedBigInteger('car_id');
            $table->date('date');
            $table->time('start');
            $table->time('end');
            $table->timestamps();

            $table->foreign('agency_id')->references('id')->on('agencies')->onDelete('cascade');
            $table->foreign('car_id')->references('id')->on('cars')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('rdv');
    }
};
