<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('users', function (Blueprint $table) {
            $table->id();
            $table->string('username', 28);
            $table->string('email', 50);
            $table->string('password', 50);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('users');
    }
};
