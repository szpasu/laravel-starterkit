<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class UserSeeder extends Seeder
{
    public function run()
    {
        DB::table('users')->insert(
            [
                'email' => 'test@example.com',
                'name' => 'test user',
                'password' => bcrypt('password'),
            ]
        );
    }
}
