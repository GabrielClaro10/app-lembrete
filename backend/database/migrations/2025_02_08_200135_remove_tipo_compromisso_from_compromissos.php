<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class RemoveTipoCompromissoFromCompromissos extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('compromissos', function (Blueprint $table) {
            $table->dropColumn('tipoCompromisso');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('compromissos', function (Blueprint $table) {
            $table->string('tipoCompromisso')->nullable();
        });
    }
}
