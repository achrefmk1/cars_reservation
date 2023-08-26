<?php

namespace App\Http\Controllers;

use App\Models\Agency;
use App\Models\RDV;
use Illuminate\Http\Request;

class RDVController extends Controller
{
    public function checkForRDV(Request $request, Agency $agency)
    {
        $rdv = RDV::where([['service', $request->service], ['agency_id', $agency->id]])->get();
        return response()->json(['data' => $rdv], 200);
    }

    public function store(Request $request)
    {
        $rdv = RDV::create($request->all());
        return response()->json(['data' => $rdv], 200);
    }
}
