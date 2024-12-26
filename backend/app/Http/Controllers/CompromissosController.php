<?php

namespace App\Http\Controllers;

use App\Models\Compromissos;
use Illuminate\Http\Request;

class CompromissosController extends Controller {


    public function __construct()
    {
        $this->middleware('auth:api');
    }
    
    public function index()
    {
        $compromissos = Compromissos::all();
        return response()->json($compromissos);
    }

    public function store(Request $request)
    {
        $validatedData = $request->validate([

            'tipoCompromisso' => 'required|string',
            'local' => 'required|string',
            'data' => 'required|date',
            'repetirAlarme' => 'required|bool',
            'descricao' => 'required|string',
            'notificacao' => 'required|int',
            'status' => 'required|string',
            'obs' => 'required|text',
        ]);

        // Criação do compromisso
        $compromisso = Compromissos::create($validatedData);

        // Resposta de sucesso
        return response()->json(['message' => 'Compromisso criado com sucesso!', 'data' => $compromisso], 201);
    }

    public function show(Compromissos $compromissos)
    {
        return response()->json($compromissos);
    }

    public function update(Request $request, Compromissos $compromissos)
    {
        // Validação dos dados
        $validatedData = $request->validate([
            'tipoCompromisso' => 'string',
            'local' => 'string',
            'data' => 'date',
            'repetirAlarme' => 'bool',
            'descricao' => 'string',
            'notificacao' => 'int',
            'status' => 'string',
            'obs' => 'text',
        ]);

        // Atualiza os campos
        $compromissos->update($validatedData);

        return response()->json(['message' => 'Compromisso atualizado com sucesso!', 'data' => $compromissos]);
    }

    public function destroy(Compromissos $compromissos)
    {
        // Deleta o compromisso
        $compromissos->delete();

        return response()->json(['message' => 'Compromisso deletado com sucesso!']);
    }
}

