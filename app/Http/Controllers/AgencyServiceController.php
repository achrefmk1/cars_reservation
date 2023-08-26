<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Service;
use App\Models\Agency;

class AgencyServiceController extends Controller
{

    public function __construct()
    {
        $this->middleware('auth:api');
    }

    public function index()
    {
        $agencyServices = Service::with('agency')->get();
        return response()->json($agencyServices);
    }

    public function getByAgency(Agency $agency)
    {
        return response()->json($agency->services);
    }

    public function store(Request $request)
    {
        $validatedData = $request->validate([
            'service' => 'required',
            'period' => 'required',
            'times' => 'required',
        ]);

        $service = new Service();
        $service->fill($validatedData);
        $service->agency()->associate($request['agency_id']);
        $service->save();

        return response()->json($service, 201);
    }

    public function show($id)
    {
        $agencyService = Service::with('agency')->findOrFail($id);
        return response()->json($agencyService);
    }

    public function update(Request $request, $id)
    {
        $agencyService = Service::findOrFail($id);

        $validatedData = $request->validate([
            'agency_id' => 'required|exists:agencies,id',
            'service' => 'required',
            'period' => 'required',
            'times' => 'required',
        ]);

        $agencyService->update($validatedData);

        return response()->json($agencyService);
    }

    public function destroy($id)
    {
        $agencyService = Service::findOrFail($id);
        $agencyService->delete();

        return response()->json(null, 204);
    }
}
