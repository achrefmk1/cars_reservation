<?php

use App\Http\Controllers\AgencyController;
use App\Http\Controllers\AgencyServiceController;
use App\Http\Controllers\AuthAPIController;
use App\Http\Controllers\CarController;
use App\Http\Controllers\DayOffController;
use App\Http\Controllers\RDVController;
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
Route::apiResource('agencies', AgencyController::class);
Route::resource('days', DayOffController::class);

Route::get('agencies/days/{agency}', [DayOffController::class, 'getDays']);

Route::post('cars/toggleStatus/{car}', [CarController::class, 'toggleStatus']);

Route::get('users', [AuthAPIController::class, 'index']);
Route::post('users/{user}', [AuthAPIController::class, 'update']);
Route::post('users/toggleStatus/{user}', [AuthAPIController::class, 'toggleStatus']);

Route::post('agencies/find', [AgencyController::class, 'find']);
Route::get('agencies/services/{agency}', [AgencyServiceController::class, 'getByAgency']);
Route::put('agencies/services/{agency}', [AgencyServiceController::class, 'update']);
Route::post('agencies/services/store', [AgencyServiceController::class, 'store']);

Route::post('rdv/store', [RDVController::class, 'store']);
Route::get('rdv/getCarHistory/{car}', [RDVController::class, 'getCarHistory']);
Route::get('rdv/getAgencyHistory/{agency}', [RDVController::class, 'getAgencyHistory']);
Route::post('rdv/{agency}', [RDVController::class, 'checkForRDV']);



Route::controller(AuthAPIController::class)->group(function () {
    Route::post('login', 'login');
    Route::post('register', 'register');
    Route::post('logout', 'logout');
});
