<?php

namespace App\Http\Controllers;

use App\Models\Agency;
use App\Models\DayOff;
use Illuminate\Http\Request;

class DayOffController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth:api');
    }

    public function index()
    {
        $days = DayOff::all();
        return response()->json($days);
    }

    public function getDays(Agency $agency)
    {
        return response()->json($agency->days);
    }

    public function store(Request $request)
    {
        $validatedData = $request->validate([
            'name' => 'required|string|max:255',
            'date' => 'required',
            'agency_id' => 'required',
        ]);

        $day = DayOff::create($validatedData);

        return response()->json($day, 201);
    }

    public function show($id)
    {
        $day = DayOff::findOrFail($id);
        return response()->json($day);
    }

    public function update(Request $request, $id)
    {
        $day = DayOff::findOrFail($id);

        $validatedData = $request->validate([
            'name' => 'required|string|max:255',
            'date' => 'required',
            'agency_id' => 'required',
        ]);

        $day->update($validatedData);

        return response()->json($day);
    }

    public function destroy($id)
    {
        $day = DayOff::findOrFail($id);
        $day->delete();

        return response()->json(null, 204);
    }
}
