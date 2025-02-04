<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Profile extends Model
{
    use HasFactory;

    public $timestamps = false;

    protected $fillable = [
        'nama',
        'tempat_lahir',
        'tanggal_lahir',
        'jenis_kelamin',
        'agama',
        'suku',
        'Nomor_KTP',
        'NPWP',
        'Kewarganegaraan',
        'alamat',
        'RT',
        'RW',
        'Provinsi',
        'Kota',
        'Kecamatan',
        'Kelurahan',
        'Dusun',
        'kode_pos',
        'jenis_tinggal',
        'telpon_rumah',
        'telpon_seluler',
        'alamat_kos',
        'kota_kos',
        'alat_transportasi',
        'email',
        'email_WBI'
    ];
}
