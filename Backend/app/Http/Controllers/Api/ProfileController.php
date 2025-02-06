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
            'nama'              => ['required', 'string'],
            'tempat_lahir'      => ['nullable', 'string'],
            'tanggal_lahir'     => ['nullable', 'date'],
            'jenis_kelamin'     => ['nullable', 'in:Laki-laki,Perempuan'],
            'agama'             => ['nullable', 'in:Islam,Kristen,Katolik,Hindu,Budha,Konghucu,Lainnya'],
            'suku'              => ['nullable', 'string'],
            'Nomor_KTP'         => ['nullable', 'string'],
            'NPWP'              => ['nullable', 'string'],
            'Kewarganegaraan'   => ['nullable', 'string'],
            'alamat'            => ['nullable', 'string'],
            'RT'                => ['nullable', 'string'],
            'RW'                => ['nullable', 'string'],
            'Provinsi'          => ['nullable', 'string'],
            'Kota'              => ['nullable', 'string'],
            'Kecamatan'         => ['nullable', 'string'],
            'Kelurahan'         => ['nullable', 'string'],
            'Dusun'             => ['nullable', 'string'],
            'kode_pos'          => ['nullable', 'string'],
            'jenis_tinggal'     => ['nullable', 'in:Sendiri,bersama Orang Tua,Sewa,Lainnya'],
            'telpon_rumah'      => ['nullable', 'string'],
            'telpon_seluler'    => ['nullable', 'string'],
            'alamat_kos'        => ['nullable', 'string'],
            'kota_kos'          => ['nullable', 'string'],
            'alat_transportasi' => ['nullable', 'string', 'in:Jalan Kaki,Kendaraan Pribadi,Kendaraan Umum,Lainnya'],
            'email'             => ['nullable', 'email'],
            'email_WBI'         => ['nullable', 'email'],
        ]);

        if ($validator->stopOnFirstFailure()->fails()) {
            Log::error("Validation failed!");
            return response('Bad Request', 400);
        }

        // Pastikan bahwa profile sudah ada
        $profile = Profile::find($id);
        Log::info($profile);
        Log::info(is_null($profile));

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
