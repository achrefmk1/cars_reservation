<?php

namespace App\Http\Controllers;

use App\Models\Agency;
use App\Models\Car;
use App\Models\DayOff;
use App\Models\RDV;
use App\Models\Service;
use Illuminate\Http\Request;

class RDVController extends Controller
{
    public function checkForRDV(Request $request, Agency $agency)
    {
        if ($request->date === null) {
            return response()->json([
                "available" => false,
                "message" => "cette date n'est pas disponible"
            ], 200);
        }
        $weekdays = [
            'Dimanche',
            'Lundi',
            'Mardi',
            'Mercredi',
            'Jeudi',
            'Vendredi',
            'Samedi',
        ];
        $dayIndex = date('w', strtotime($request->date));
        $day = $weekdays[$dayIndex];
        $daysOff = DayOff::where([
            ['date', $request->date],
            ['agency_id', $agency->id]
        ])->get();

        if (count($daysOff) > 0) {
            return response()->json([
                "available" => false,
                "message" => "c'est un jour férié"
            ], 200);
        }

        if (!in_array($day, json_decode($agency->workDays))) {
            return response()->json([
                "available" => false,
                "message" => "l'agence est fermée dans cette date"
            ], 200);
        }

        $rdv = RDV::where([
            ['service', $request->service],
            ['date', $request->date],
            ['agency_id', $agency->id]
        ])->get();

        $service = Service::where([
            ['service', $request->service],
            ['agency_id', $agency->id]
        ])->first();
        $rdvs = floor(count($rdv) / $service->times);
        $start = date("H:i:s", strtotime($agency->start) + ($rdvs * $service->period * 60 * 60));
        $end = date("H:i:s", strtotime($start) + ($service->period * 60 * 60));

        if (strtotime($end) <= strtotime($agency->end)) {
            return response()->json([
                "available" => true,
                "date" => $request->date,
                "start" => $start,
                "end" => $end,
                "message" => "Votre rendez-vous sera : " . $start
            ], 200);
        } else {
            return response()->json([
                "available" => false,
                "message" => "cette date n'est pas disponible"
            ], 200);
        }
    }

    public function store(Request $request)
    {
        $rdv = RDV::create($request->all());
        return response()->json(['data' => $rdv], 200);
    }

    public function getCarHistory(Car $car)
    {
        $cars = RDV::where('car_id', $car->id)->with('agency')->get();
        return response()->json(['data' => $cars], 200);
    }

    public function getAgencyHistory(Agency $agency)
    {
        $cars = RDV::where('agency_id', $agency->id)->with('car')->get();
        return response()->json(['data' => $cars], 200);
    }
}
