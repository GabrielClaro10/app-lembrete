<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Auth;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use App\Models\User;

class AuthController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth:api', ['except' => ['login', 'register']]);
    }

    public function login()
    {
        $credentials = request(['email', 'password']);

        if (! $token = auth()->attempt($credentials)) {
            return response()->json(['error' => 'Unauthorized'], 401);
        }

        return $this->respondWithToken($token);
    }

    public function register(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'email' => 'required|email|unique:users,email',
            'password' => 'required|min:6|confirmed',
            'nome' => 'required|string|max:255',
            'data_nascimento' => 'required|string|max:15',
            'telefone' => 'required|string|max:15',
            'foto' => 'nullable|string|max:255',
        ]);

        if ($validator->fails()) {
            return response()->json($validator->errors(), 400);
        }

        // Criação do usuário
        $user = User::create([
            'email' => $request->email,
            'password' => Hash::make($request->password),
            'nome' => $request->nome,
            'data_nascimento' => $request->data_nascimento,
            'telefone' => $request->telefone,
            'foto' => $request->foto,
        ]);

        // Gerar token para o novo usuário
        $token = auth()->login($user);  // Login automático após criar o usuário

        return response()->json([
            'message' => 'Usuário criado com sucesso!',
            'user' => $user,
            'access_token' => $token,
            'token_type' => 'bearer',
            'expires_in' => auth()->factory()->getTTL() * 60
        ], 201);
    }

    public function me()
    {
        return response()->json(auth()->user());
    }

    public function logout()
    {
        auth()->logout();

        return response()->json(['message' => 'Successfully logged out']);
    }

    public function refresh()
    {
        return $this->respondWithToken(auth()->refresh());
    }

    protected function respondWithToken($token)
    {
        return response()->json([
            'user' => auth()->user(),
            'access_token' => $token,
            'token_type' => 'bearer',
            'expires_in' => auth()->factory()->getTTL() * 60
        ]);
    }
}
