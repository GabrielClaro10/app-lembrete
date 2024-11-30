<?php

namespace App\Http\Controllers;

use App\Models\Compromissos;
use Illuminate\Http\Request;

class CompromissosController extends Controller {
    
    public function index()
    {
        $compromissos = Compromissos::all();
        return response()->json($compromissos);
    }

    public function store(Request $request)
    {
        $validatedData = $request->validate([
            'localizacao' => 'required|string',
            'categoria' => 'required|string',
            'data' => 'required|date',
            'hora' => 'required|string',
            'descricao' => 'required|string',
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
            'localizacao' => 'string',
            'categoria' => 'string',
            'data' => 'date',
            'hora' => 'string',
            'descricao' => 'string',
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

