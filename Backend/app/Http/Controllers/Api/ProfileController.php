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
            'nama' => ['required', 'string'],
            'tempat_lahir' => ['required', 'string'],
            'tanggal_lahir' => ['required', 'date'],
            'jenis_kelamin' => ['required', 'in:Laki-laki,Perempuan'],
            'agama' => ['required', 'in:Islam,Kristen,Katolik,Hindu,Budha,Konghucu,Lainnya'],
            'suku' => ['required', 'string'],
            'Nomor_KTP' => ['required', 'string'],
            'NPWP' => ['nullable', 'string'],
            'Kewarganegaraan' => ['required', 'string'],
            'alamat' => ['required', 'string'],
            'RT' => ['required', 'string'],
            'RW' => ['required', 'string'],
            'Provinsi' => ['required', 'string'],
            'Kota' => ['required', 'string'],
            'Kecamatan' => ['required', 'string'],
            'Kelurahan' => ['required', 'string'],
            'Dusun' => ['nullable', 'string'],
            'kode_pos' => ['required', 'string'],
            'jenis_tinggal' => ['required', 'in:Sendiri,bersama Orang Tua,Sewa,Lainnya'],
            'telpon_rumah' => ['nullable', 'string'],
            'telpon_seluler' => ['required', 'string'],
            'alamat_kos' => ['nullable', 'string'],
            'kota_kos' => ['nullable', 'string'],
            'alat_transportasi' => ['required', 'in:Jalan Kaki,Kendaraan Pribadi,Kendaraan Umum,Lainnya'],
            'email' => ['required', 'email'],
            'email_WBI' => ['nullable', 'email'],
        ]);

        if ($validator->stopOnFirstFailure()->fails()) {
            return response('Bad Request', 400);
        }

        // Pastikan bahwa profile sudah ada
        $profile = Profile::find($id);

        if (is_null($profile)) {
            return response('Profil tidak ditemukan', 500);
        }

        $profile->nama = $request->nama;
        $profile->tempat_lahir = $request->tempat_lahir;
        $profile->tanggal_lahir = $request->tanggal_lahir;
        $profile->jenis_kelamin = $request->jenis_kelamin;
        $profile->agama = $request->agama;
        $profile->suku = $request->suku;
        $profile->Nomor_KTP = $request->Nomor_KTP;
        $profile->NPWP = $request->NPWP;
        $profile->Kewarganegaraan = $request->Kewarganegaraan;
        $profile->alamat = $request->alamat;
        $profile->RT = $request->RT;
        $profile->RW = $request->RW;
        $profile->Provinsi = $request->Provinsi;
        $profile->Kota = $request->Kota;
        $profile->Kecamatan = $request->Kecamatan;
        $profile->Kelurahan = $request->Kelurahan;
        $profile->Dusun = $request->Dusun;
        $profile->kode_pos = $request->kode_pos;
        $profile->jenis_tinggal = $request->jenis_tinggal;
        $profile->telpon_rumah = $request->telpon_rumah;
        $profile->telpon_seluler = $request->telpon_seluler;
        $profile->alamat_kos = $request->alamat_kos;
        $profile->kota_kos = $request->kota_kos;
        $profile->alat_transportasi = $request->alat_transportasi;
        $profile->email = $request->email;
        $profile->email_WBI = $request->email_WBI;

        $profile->save();

        return response()->json($profile);
    }
}
