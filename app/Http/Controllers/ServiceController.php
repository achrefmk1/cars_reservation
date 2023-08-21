<?php

namespace App\Http\Controllers;

use App\Models\Service;
use Illuminate\Http\Request;
use Illuminate\Http\Response;

class ServiceController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth:api');
    }
    public function index()
    {
        $services = Service::all();
        return response()->json(['data' => $services], Response::HTTP_OK);
    }

    public function store(Request $request)
    {
        $service = Service::create($request->all());
        return response()->json(['data' => $service], Response::HTTP_CREATED);
    }

    public function show(Service $service)
    {
        return response()->json(['data' => $service], Response::HTTP_OK);
    }

    public function update(Request $request, Service $service)
    {
        $service->update($request->all());
        return response()->json(['data' => $service], Response::HTTP_OK);
    }

    public function destroy(Service $service)
    {
        $service->delete();
        return response()->json(null, Response::HTTP_NO_CONTENT);
    }
}
