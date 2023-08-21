<?php

namespace App\Http\Controllers;

use App\Models\Agency;
use App\Models\Service;
use Illuminate\Http\Request;
use Illuminate\Http\Response;

class AgencyServiceController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth:api');
    }

    public function assign(Agency $agency, Service $service)
    {
        $agency->services()->syncWithoutDetaching($service->id);
        return response()->json(['message' => 'Service assigned to agency successfully.'], Response::HTTP_OK);
    }

    public function unassign(Agency $agency, Service $service)
    {
        $agency->services()->detach($service->id);
        return response()->json(['message' => 'Service unassigned from agency successfully.'], Response::HTTP_OK);
    }
}
