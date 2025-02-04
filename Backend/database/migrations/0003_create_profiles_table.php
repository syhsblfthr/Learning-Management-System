<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('profiles', function (Blueprint $table) {
            $table->id();
            $table->string('nama');
            $table->string('tempat_lahir')->nullable();
            $table->date('tanggal_lahir')->nullable();
            $table->enum('jenis_kelamin', ['Laki-laki', 'Perempuan'])->nullable();
            $table->enum('agama', ['Islam', 'Kristen', 'Katolik', 'Hindu', 'Budha', 'Konghucu', 'Lainnya'])->nullable();
            $table->string('suku')->nullable();
            $table->string('Nomor_KTP')->nullable()->unique();
            $table->string('NPWP')->nullable();
            $table->string('Kewarganegaraan' )->nullable();
            $table->text('alamat')->nullable();
            $table->string('RT', 3)->nullable();
            $table->string('RW', 3)->nullable();
            $table->string('Provinsi')->nullable();
            $table->string('Kota')->nullable();
            $table->string('Kecamatan')->nullable();
            $table->string('Kelurahan')->nullable();
            $table->string('Dusun')->nullable();
            $table->string('kode_pos', 6)->nullable();
            $table->enum('jenis_tinggal', ['Sendiri', 'bersama Orang Tua', 'Sewa', 'Lainnya'])->nullable();
            $table->string('telpon_rumah')->nullable();
            $table->string('telpon_seluler')->nullable();
            $table->text('alamat_kos')->nullable();
            $table->string('kota_kos')->nullable();
            $table->enum('alat_transportasi', ['Jalan Kaki', 'Kendaraan Pribadi', 'Kendaraan Umum', 'Lainnya'])->nullable();
            $table->string('email')->nullable()->unique();
            $table->string('email_WBI')->nullable();

            
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('profiles');
    }
};
