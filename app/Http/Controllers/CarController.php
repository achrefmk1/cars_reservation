<?php

namespace App\Http\Controllers;

use App\Models\Car;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;

class CarController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth:api');
    }

    public function index()
    {
        $cars = Car::all();
        return response()->json(['data' => $cars], Response::HTTP_OK);
    }

    public function store(Request $request)
    {
        $car = Car::create($request->all() + ['user_id' => Auth::user()->id]);
        return response()->json(['data' => $car], Response::HTTP_CREATED);
    }

    public function show(Car $car)
    {
        return response()->json(['data' => $car], Response::HTTP_OK);
    }

    public function update(Request $request, Car $car)
    {
        $car->update($request->all());
        return response()->json(['data' => $car], Response::HTTP_OK);
    }

    public function destroy(Car $car)
    {
        $car->delete();
        return response()->json(null, Response::HTTP_NO_CONTENT);
    }

    public function toggleStatus(Car $car)
    {
        try {
            $car->isEnabled = $car->isEnabled === 'yes' ? 'no' : 'yes';
            $car->save();

            return response()->json([
                'error' => false,
                'message' => 'car updated successfully',
                'car' => $car
            ]);
        } catch (Exception $e) {
            Log::critical('api update car : ' . $e->getMessage());
            return response()->json([
                'error' => true,
                'message' => $e->getMessage(),
            ]);
        }
    }
}
