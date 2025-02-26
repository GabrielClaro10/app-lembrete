<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Compromissos extends Model
{
    use HasFactory;

    protected $fillable = [
        'local',
        'data',
        'descricao',
        'notificacao',
        'status',
        'obs',
        'idade',
        'id_users',
        'id_categoria',
    ];
}
