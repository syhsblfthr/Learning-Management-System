<?php

namespace App\Http\Controllers;

use App\Models\User;
use App\Models\Profile;
use Illuminate\Http\Request;

use Illuminate\Support\Facades\Log;

class Authentication extends Controller {
    public function login(Request $request)
    {
        Log::info('username: ' . $request['username']);
        Log::info('password: ' . $request['password']);

        $isUsernameEmail = filter_var($request['username'], FILTER_VALIDATE_EMAIL);
        $user = null;

        $username = $request['username'];
        Log::info("request[\'username\'] = $username");

        if ($isUsernameEmail) {
            $user = User::where('email', $request['username'])->where('password', $request['password'])->first();
        }
        else {
            $profile = Profile::firstWhere('nama', $request['username']);
            $user = User::firstWhere('profile_id', $profile['id']);
        }

        if (!is_null($user) && $user['password'] == $request['password']) {
            return response(json_encode(['id' => $user['id']]), 201);
        }
        return response('Gagal login!', 401);
    }

    public function create(Request $request)
    {
        $user = User::create([
            'username' => $request['username'],
            'email' => $request['email'],
            'password' => $request['password']
        ]);

        if ($user) {
            return response('Berhasil membuat akun!', 201);
        }

        return response('Gagal membuat akun!', 401);
    }
}
