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
            'data' => 'required|string',
            'repetirAlarme' => 'required|int',
            'descricao' => 'required|string',
            'notificacao' => 'required|string',
            'status' => 'required|string',
            'obs' => 'required|string',
            'id_users' => 'required|int',
            'id_categoria' => 'required|int',
        ]);

        // Criação do compromisso
        $compromisso = Compromissos::create($validatedData);

        // Resposta de sucesso
        return response()->json(['message' => 'Compromisso criado com sucesso!', 'data' => $compromisso], 201);
    }

    public function show($id)
    {
        $compromisso = Compromissos::findOrFail($id); 
        return response()->json($compromisso);
    }
    

    public function update(Request $request, $id)
    {
        // Validação dos dados
        $validatedData = $request->validate([
            'tipoCompromisso' => 'string',
            'local' => 'string',
            'data' => 'string',
            'repetirAlarme' => 'int',
            'descricao' => 'string',
            'notificacao' => 'string',
            'status' => 'string',
            'obs' => 'string',
        ]);

        $compromissos = Compromissos::findOrFail($id);

        // Atualiza os campos
        $compromissos->update($validatedData);

        return response()->json(['message' => 'Compromisso atualizado com sucesso!', 'data' => $compromissos]);
    }

    public function destroy($id)
    {
        $compromissos = Compromissos::findOrFail($id); 

        // Deleta o compromisso
        $compromissos->delete();

        return response()->json(['message' => 'Compromisso deletado com sucesso!']);
    }
}

