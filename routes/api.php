<?php

use App\Http\Controllers\AgencyController;
use App\Http\Controllers\AgencyServiceController;
use App\Http\Controllers\AuthAPIController;
use App\Http\Controllers\CarController;
use App\Http\Controllers\ServiceController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

Route::apiResource('services', ServiceController::class);
Route::apiResource('cars', CarController::class);
Route::post('cars/toggleStatus/{car}', [CarController::class, 'toggleStatus']);
Route::apiResource('agencies', AgencyController::class);
Route::get('users', [AuthAPIController::class, 'index']);
Route::post('users/{user}', [AuthAPIController::class, 'update']);
Route::post('users/toggleStatus/{user}', [AuthAPIController::class, 'toggleStatus']);

Route::post('agencies/{agency}/services/{service}', [AgencyServiceController::class, 'assign']);
Route::delete('agencies/{agency}/services/{service}', [AgencyServiceController::class, 'unassign']);



Route::controller(AuthAPIController::class)->group(function () {
    Route::post('login', 'login');
    Route::post('register', 'register');
    Route::post('logout', 'logout');
});
