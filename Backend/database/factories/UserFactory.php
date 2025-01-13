<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

class UserFactory extends Factory
{
    public function definition(): array
    {
        return [
            'username' => fake()->userName(),
            'password' => fake()->regexify('[A-Z]{5}[0-4]{3}')
        ];
    }
}
