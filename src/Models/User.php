<?php

namespace Src\Models;

class User
{
    public $id_usuario;
    public $id_empresa;
    public $nome;
    public $email;
    public $senha;
    public $perfil;
    public $status;

    public function __construct($id_usuario, $id_empresa, $nome, $email, $senha, $perfil, $status)
    {
        $this->id_usuario = $id_usuario;
        $this->id_empresa = $id_empresa;
        $this->nome       = $nome;
        $this->email      = $email;
        $this->senha      = $senha;
        $this->perfil     = $perfil;
        $this->status     = $status;
    }
}
