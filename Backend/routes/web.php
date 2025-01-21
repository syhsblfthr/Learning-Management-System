<?php

use App\Http\Controllers\Authentication;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\ProfileController;

Route::prefix('authentication')->group(function() {
    Route::post('/login', [Authentication::class, 'login']);
    Route::post('/create', [Authentication::class, 'create']);
});

Route::prefix('api')->middleware('api')->group(function () {
    Route::get('profile/{id}', [ProfileController::class, 'show']);
    Route::put('profile/{id}', [ProfileController::class, 'update']);
});
