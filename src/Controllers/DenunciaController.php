<?php

namespace Src\Controllers;

use PDO;
use Src\Models\Denuncia;

class DenunciaController
{
    private $pdo;

    public function __construct(PDO $pdo)
    {
        $this->pdo = $pdo;
    }

    // Listar todas
    public function getAll()
    {
        $stmt = $this->pdo->query("
            SELECT id_empresa, nome, cnpj, email_principal, telefone, endereco, status 
            FROM empresas
        ");
        $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

        $empresas = [];
        foreach ($rows as $row) {
            $empresas[] = new Denuncia(
                $row['id_empresa'],
                $row['nome'],
                $row['cnpj'],
                $row['email_principal'],
                $row['telefone'],
                $row['endereco'],
                $row['status']
            );
        }

        return $empresas;
    }

    // Criar nova empresa
    public function create($nome, $cnpj, $email_principal, $telefone, $endereco, $status)
    {
        $sql = "INSERT INTO empresas (nome, cnpj, email_principal, telefone, endereco, status) 
                VALUES (:nome, :cnpj, :email_principal, :telefone, :endereco, :status)";
        $stmt = $this->pdo->prepare($sql);

        return $stmt->execute([
            ':nome'            => $nome,
            ':cnpj'            => $cnpj,
            ':email_principal' => $email_principal,
            ':telefone'        => $telefone,
            ':endereco'        => $endereco,
            ':status'          => $status
        ]);
    }

    // Atualizar empresa
    public function update($id_empresa, $nome, $cnpj, $email_principal, $telefone, $endereco, $status)
    {
        $sql = "UPDATE empresas 
                   SET nome = :nome, 
                       cnpj = :cnpj, 
                       email_principal = :email_principal, 
                       telefone = :telefone, 
                       endereco = :endereco, 
                       status = :status
                 WHERE id_empresa = :id_empresa";
        $stmt = $this->pdo->prepare($sql);

        return $stmt->execute([
            ':id_empresa'      => $id_empresa,
            ':nome'            => $nome,
            ':cnpj'            => $cnpj,
            ':email_principal' => $email_principal,
            ':telefone'        => $telefone,
            ':endereco'        => $endereco,
            ':status'          => $status
        ]);
    }

    // Deletar empresa
    public function delete($id_empresa)
    {
        $sql = "DELETE FROM empresas WHERE id_empresa = :id_empresa";
        $stmt = $this->pdo->prepare($sql);

        return $stmt->execute([':id_empresa' => $id_empresa]);
    }
}
