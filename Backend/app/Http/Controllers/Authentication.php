<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;

use Illuminate\Support\Facades\Log;

class Authentication extends Controller {
    public function login(Request $request)
    {
        $user = User::where('username', $request['username'])->where('password', $request['password'])->first();

        if ($user) {
            return response('Berhasil login!', 201);
        }

        return response('Gagal login!', 401);
    }

    public function create(Request $request)
    {
        $user = User::create([
            'username' => $request['username'],
            'password' => $request['password']
        ]);

        if ($user) {
            return response('Berhasil membuat akun!', 201);
        }

        return response('Gagal membuat akun!', 401);
    }
}
