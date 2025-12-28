<?php

namespace Src\Models;

class Denuncia
{
    public $id_empresa;
    public $nome;
    public $cnpj;
    public $email_principal;
    public $telefone;
    public $endereco;
    public $status;

    public function __construct($id_empresa, $nome, $cnpj, $email_principal, $telefone, $endereco, $status)
    {
        $this->id_empresa      = $id_empresa;
        $this->nome            = $nome;
        $this->cnpj            = $cnpj;
        $this->email_principal = $email_principal;
        $this->telefone        = $telefone;
        $this->endereco        = $endereco;
        $this->status          = $status;
    }
}
