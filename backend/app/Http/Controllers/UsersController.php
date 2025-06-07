<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Auth;

class UsersController extends Controller
{
    public function index()
    {
        $users = User::all();
        return response()->json($users);
    }

    public function __construct()
    {
         $this->middleware('auth:api');
    }


    public function show($id)
    {
        $user = User::find($id);
    
        if ($user) {
            return response()->json([
                'message' => 'Usuário encontrado',
                'user' => $user
            ]);
        }
    
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
        'foto' => 'nullable|string',
    ]);

    $user = User::findOrFail($id);

    $user->update([
        'nome' => $validated['nome'],
        'data_nascimento' => $validated['data_nascimento'],
        'telefone' => $validated['telefone'],
    ]);

    if (!empty($validated['foto'])) {
        $path = str_replace(asset('storage/'), '', $validated['foto']);
        $user->foto = $path;
        $user->save();
    }

    return response()->json([
        'message' => 'Usuário atualizado com sucesso!',
        'data' => [
            'id' => $user->id,
            'nome' => $user->nome,
            'foto' => $user->foto ? asset('storage/' . $user->foto) : null,
        ]
    ]);
}

 public function upload(Request $request)
    {
        if ($request->hasFile('foto')) {
            $path = $request->file('foto')->store('user_photos', 'public');

            return response()->json([
                'success' => true,
                'path' => asset('storage/' . $path)
            ]);
        }

        return response()->json([
         'success' => true,
          'path' => $path,
    ]);
    }
}