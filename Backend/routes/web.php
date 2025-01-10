<?php

use App\Http\Controllers\Authentication;
use Illuminate\Support\Facades\Route;

Route::prefix('authentication')->group(function() {
    Route::post('/login', [Authentication::class, 'login']);
    Route::post('/create', [Authentication::class, 'create']);
});
