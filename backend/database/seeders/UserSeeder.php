<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\User;

class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        User::create([
        'nome' => 'Gabriel',
        'data_nascimento' => '1998-10-21',
        'email' => 'gabriel@teste.com',
        'tema' => true,
        'telefone' => '99999999999',
        ]);
    }
}
