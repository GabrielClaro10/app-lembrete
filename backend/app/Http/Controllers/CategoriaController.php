<?php

namespace App\Http\Controllers;

use App\Models\Categoria;
use Illuminate\Http\Request;

class CategoriaController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
            $user = auth()->user();

            if(!$user){
                return response()->json(['erro' => 'Usuário não autenticado'], 401);
            }

            $categoria = Categoria::where('user_id', $user->id)->get();

            return response()->json($categoria);
        
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $validatedData = $request->validate([

            'nome' => 'required|string',
            'status' => 'required|string',
            'user_id' => 'required|int',
        ]);

        // Criação do categoria
        $categoria = Categoria::create($validatedData);

        // Resposta de sucesso
        return response()->json(['message' => 'Categoria criado com sucesso!', 'data' => $categoria], 201);
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Categoria  $categoria
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $categoria = Categoria::findOrFail($id); 
        return response()->json($categoria);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\Categoria  $categoria
     * @return \Illuminate\Http\Response
     */
    public function edit(Categoria $categoria)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Categoria  $categoria
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        // Validação dos dados
        $validatedData = $request->validate([
            'nome' => 'string',
            'updated_at' => 'string',
            'status' => 'string',
        ]);

        $categoria = Categoria::findOrFail($id);

        // Atualiza os campos
        $categoria->update($validatedData);

        return response()->json(['message' => 'Categoria atualizado com sucesso!', 'data' => $categoria]);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Categoria  $categoria
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $categoria = Categoria::findOrFail($id); 

        // Deleta o compromisso
        $categoria->delete();

        return response()->json(['message' => 'Categoria deletado com sucesso!']);
    }
}
