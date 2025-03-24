<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Password;
use Illuminate\Support\Facades\Validator;

class PasswordController extends Controller
{
    // Envia o link de recuperação de senha
    public function sendResetLinkEmail(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'email' => 'required|email',
        ]);

        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()->first()], 400);
        }

        $status = Password::sendResetLink(
            $request->only('email')
        );

        if ($status == Password::RESET_LINK_SENT) {
            return response()->json(['message' => 'Link de recuperação enviado!'], 200);
        } else {
            return response()->json(['error' => 'Falha ao enviar o link de recuperação.'], 400);
        }
    }

    // Redefine a senha
    public function reset(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'email' => 'required|email',
            'password' => 'required|confirmed|min:8',
            'token' => 'required',
        ]);

        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()->first()], 400);
        }

        $status = Password::reset(
            $request->only('email', 'password', 'password_confirmation', 'token'),
            function ($user, $password) {
                $user->password = bcrypt($password);
                $user->save();
            }
        );

        if ($status == Password::PASSWORD_RESET) {
            return response()->json(['message' => 'Senha redefinida com sucesso!'], 200);
        } else {
            return response()->json(['error' => 'Token de recuperação inválido ou expirado.'], 400);
        }
    }
}
