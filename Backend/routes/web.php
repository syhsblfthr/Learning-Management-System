<?php

use App\Http\Controllers\Authentication;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\ProfileController;

Route::prefix('authentication')->group(function() {
    Route::post('/login', [Authentication::class, 'login']);
    Route::post('/create', [Authentication::class, 'create']);
});

Route::prefix('api')->middleware('api')->group(function () {
    Route::get('profiles', [ProfileController::class, 'index']);
    Route::post('profiles', [ProfileController::class, 'store']);
    Route::put('profiles/{id}', [ProfileController::class, 'update']);
    Route::delete('profiles/{id}', [ProfileController::class, 'destroy']);
});


