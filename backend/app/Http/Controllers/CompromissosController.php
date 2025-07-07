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

        $user = auth()->user();

        if(!$user){
            return response()->json(['erro' => 'Usuário não autenticado'], 401);
        }

        $compromissos = Compromissos::where('id_users', $user->id)->get();
        
        return response()->json($compromissos);
    }

    public function store(Request $request)
    {
        $validatedData = $request->validate([

            'local' => 'required|string',
            'data' => 'required|string',
            'descricao' => 'required|string',
            'status' => 'required|string',
            'obs' => 'required|string',
            'id_users' => 'required|int',
            'id_categoria' => 'required|int',
        ]);

        $compromisso = Compromissos::create($validatedData);


        return response()->json(['message' => 'Compromisso criado com sucesso!', 'data' => $compromisso], 201);
    }

    public function show($id)
    {
        $compromisso = Compromissos::findOrFail($id); 
        return response()->json($compromisso);
    }
    

    public function update(Request $request, $id)
    {
        $validatedData = $request->validate([
            'local' => 'string',
            'data' => 'string',
            'descricao' => 'string',
            'status' => 'string',
            'obs' => 'string',
        ]);

        $compromissos = Compromissos::findOrFail($id);

        $compromissos->update($validatedData);

        return response()->json(['message' => 'Compromisso atualizado com sucesso!', 'data' => $compromissos]);
    }

    public function destroy($id)
    {
        $compromissos = Compromissos::findOrFail($id); 

        $compromissos->delete();

        return response()->json(['message' => 'Compromisso deletado com sucesso!']);
    }
}

