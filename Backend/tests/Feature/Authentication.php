<?php

namespace Tests\Feature;

use Tests\TestCase;
use PHPUnit\Framework\Attributes\DataProvider;

class Authentication extends TestCase
{
    public static function credentialsProvider()
    {
        return [
            [
                'username' => fake()->userName(),
                'password' => fake()->password(8, 50)
            ]
        ];
    }
    

    #[DataProvider('credentialsProvider')]
    public function test_user_bisa_buat_akun(string $username, string $password)
    {
        $response = $this->postJson('/authentication/create', [
            'username' => $username,
            'password' => $password
        ]);

        $response->assertStatus(201);
    }
    
    #[DataProvider('credentialsProvider')]
    public function test_user_bisa_log_in(string $username, string $password)
    {
        $response = $this->postJson('/authentication/login', [
            'username' => $username,
            'password' => $password
        ]);

        $response->assertStatus(201);
    }
}
