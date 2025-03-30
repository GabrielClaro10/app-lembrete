<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;


class UsersController extends Controller
{
    public function index()
    {
        $users = User::all();
        return response()->json($users);
    }

    public function show($id)
    {
        // Recupera o usuário pelo ID
        $user = User::find($id);
    
        if ($user) {
            return response()->json([
                'message' => 'Usuário encontrado',
                'user' => $user
            ]);
        }
    
        // Caso o usuário não seja encontrado
        return response()->json(['message' => 'Usuário não encontrado'], 404);
    }

    

    public function store(Request $request)
    {

        
        $validated = $request->validate([
            'nome' => 'required|string|max:255',
            'data_nascimento' => 'required|string',
            'email' => 'required|email|unique:users,email',
            'telefone' => 'required|string|max:15',
        ]);

        $user = User::create($validated);

        return response()->json([
            'message' => 'Usuário criado com sucesso!',
            'user' => $user
        ], 201);
    }

    public function update(Request $request, $id)
    {

        $validated = $request->validate([
            'nome' => 'required|string|max:255',
            'data_nascimento' => 'required|string',
            'telefone' => 'required|string|max:15',
            'foto' => 'nullable|image|mimes:jpeg,png,jpg,gif,svg|max:2048', 
        ]);

        $user = User::findOrFail($id);

        $user->update($validated);

        if ($request->hasFile('foto')) {
            if ($user->foto) {
                Storage::delete($user->foto);
            }
    
            // Armazena a nova foto
            $path = $request->file('foto')->store('user_photos', 'public');
            $data['foto'] = $path;
        }

        return response()->json(['message' => 'Usuário atualizado com sucesso!', 'data' => $user]);

    }


}

