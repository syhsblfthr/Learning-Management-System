<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Profile;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class ProfileController extends Controller
{
    // Ambil data profil
    public function show($id)
    {
        $profile = Profile::findOrFail($id);
        return response()->json($profile);
    }

    // Update data profil
    public function update(Request $request, $id)
    {
        $profile = Profile::find($id);

        $validator = Validator::make($request->all(), [
            'username' => 'required|string|unique:profiles,username,' . $id,
            'email' => 'required|email|unique:profiles,email,' . $id,
            'nomor_induk_sekolah' => 'required|string|unique:profiles,nomor_induk_sekolah,' . $id,
            'kota' => 'required|string',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        if ($profile == null) {
            $profile = new Profile();
        }

        $profile->username = $request->username;
        $profile->email = $request->email;
        $profile->nomor_induk_sekolah = $request->nomor_induk_sekolah;
        $profile->kota = $request->kota;

        $profile->save();
        return response()->json($profile);
    }
}
