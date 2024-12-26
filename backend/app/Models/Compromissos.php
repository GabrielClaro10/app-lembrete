<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Compromissos extends Model
{
    use HasFactory;

    protected $fillable = [
        'tipoCompromisso',
        'local',
        'data',
        'repetirAlarme',
        'descricao',
        'notificacao',
        'status',
        'obs',
        'idade'
    ];
}
