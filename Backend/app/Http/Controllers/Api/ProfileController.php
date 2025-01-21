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
        $profile = Profile::findOrFail($id);

        $validator = Validator::make($request->all(), [
            'username' => 'required|string|unique:profiles,username,' . $id,
            'email' => 'required|email|unique:profiles,email,' . $id,
            'nomor_induk_sekolah' => 'required|string|unique:profiles,nomor_induk_sekolah,' . $id,
            'kota' => 'required|string',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $profile->update($request->only('username', 'email', 'nomor_induk_sekolah', 'kota'));
        return response()->json($profile);
    }
}
