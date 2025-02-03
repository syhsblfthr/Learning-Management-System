<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Profile;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

use Illuminate\Support\Facades\Log;

class ProfileController extends Controller
{
    // Ambil data profil
    public function show(Request $request, $id)
    {
        Log::info("ProfileController::show dipanggil!");

        $profile = Profile::find($id);

        if (is_null($profile)) {
            $profile = new Profile();
            $user = User::find($id);

            $profile->username = $user->username;
            $profile->email = $user->email;

            $profile->save();
        }

        return response()->json($profile);
    }

    // Update data profil
    public function update(Request $request, $id)
    {
        // Pastikan bahwa $request berdasarkan format yang benar
        $validator = Validator::make($request->all(), [
            'username' => ['required', 'string'],
            'email' => ['required', 'email'],
            'nomor_induk_sekolah' => ['required', 'numeric'],
            'kota' => ['required', 'string'],
        ]);

        if ($validator->stopOnFirstFailure()->fails()) {
            return response('Bad Request', 400);
        }

        // Pastikan bahwa profile sudah ada
        $profile = Profile::find($id);

        if (is_null($profile)) {
            return response('Profil tidak ditemukan', 500);
        }

        $profile->username = $request->username;
        $profile->email = $request->email;
        $profile->nomor_induk_sekolah = $request->nomor_induk_sekolah;
        $profile->kota = $request->kota;

        $profile->save();

        return response()->json($profile);
    }
}
