<?php

namespace App\Http\Controllers;

use App\Models\Agency;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\Auth;

class AgencyController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth:api');
    }

    public function index()
    {
        $agencies = Agency::all();
        return response()->json(['data' => $agencies], Response::HTTP_OK);
    }

    public function store(Request $request)
    {
        $agency = Agency::create($request->all() + ['user_id' => Auth::user()->id]);
        return response()->json(['data' => $agency], Response::HTTP_CREATED);
    }

    public function show(Agency $agency)
    {
        return response()->json(['data' => $agency->services], Response::HTTP_OK);
    }

    public function update(Request $request, Agency $agency)
    {
        $agency->update($request->all());
        return response()->json(['data' => $agency], Response::HTTP_OK);
    }

    public function destroy(Agency $agency)
    {
        $agency->delete();
        return response()->json(null, Response::HTTP_NO_CONTENT);
    }

    
}
