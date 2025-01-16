<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Profile;
use Illuminate\Http\Request;

class ProfileController extends Controller
{
    // Ambil semua profil
    public function index()
    {
        $profiles = Profile::all();
        return response()->json($profiles);
    }

    // Tambah profil baru
    public function store(Request $request)
    {
        $profile = Profile::create([
            'name' => $request->name,
            'email' => $request->email,
        ]);
        return response()->json($profile, 201);
    }

    // Update profil berdasarkan id
    public function update(Request $request, $id)
    {
        $profile = Profile::findOrFail($id);
        $profile->update([
            'name' => $request->name,
            'email' => $request->email,
        ]);
        return response()->json($profile);
    }

    // Hapus profil berdasarkan id
    public function destroy($id)
    {
        $profile = Profile::findOrFail($id);
        $profile->delete();
        return response()->json(null, 204);
    }
}
