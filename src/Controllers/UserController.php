<?php

namespace Src\Controllers;

use PDO;
use Src\Models\User;

class UserController
{
    private $pdo;

    public function __construct(PDO $pdo)
    {
        $this->pdo = $pdo;
    }

    // READ (listar todos usuários)
    public function getAll()
    {
        $stmt = $this->pdo->query("
            SELECT id_usuario, id_empresa, nome, email, senha, perfil, status 
            FROM usuarios
        ");
        $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

        $usuarios = [];
        foreach ($rows as $row) {
            $usuarios[] = new User(
                $row['id_usuario'],
                $row['id_empresa'],
                $row['nome'],
                $row['email'],
                $row['senha'],
                $row['perfil'],
                $row['status']
            );
        }

        return $usuarios;
    }

    // CREATE
    public function create($id_empresa, $nome, $email, $senha, $perfil, $status)
    {
        $stmt = $this->pdo->prepare("
            INSERT INTO usuarios (id_empresa, nome, email, senha, perfil, status) 
            VALUES (:id_empresa, :nome, :email, :senha, :perfil, :status)
        ");

        return $stmt->execute([
            ':id_empresa' => $id_empresa,
            ':nome'       => $nome,
            ':email'      => $email,
            ':senha'      => password_hash($senha, PASSWORD_BCRYPT), // segurança
            ':perfil'     => $perfil,
            ':status'     => $status
        ]);
    }

    // UPDATE
    public function update($id_usuario, $nome, $email, $senha, $perfil, $status)
    {
        $sql = "
            UPDATE usuarios 
            SET nome = :nome, email = :email, perfil = :perfil, status = :status
        ";

        // só altera a senha se for enviada
        if (!empty($senha)) {
            $sql .= ", senha = :senha";
        }

        $sql .= " WHERE id_usuario = :id_usuario";

        $stmt = $this->pdo->prepare($sql);

        $params = [
            ':id_usuario' => $id_usuario,
            ':nome'       => $nome,
            ':email'      => $email,
            ':perfil'     => $perfil,
            ':status'     => $status
        ];

        if (!empty($senha)) {
            $params[':senha'] = password_hash($senha, PASSWORD_BCRYPT);
        }

        return $stmt->execute($params);
    }

    // DELETE
    public function delete($id_usuario)
    {
        $stmt = $this->pdo->prepare("DELETE FROM usuarios WHERE id_usuario = :id_usuario");
        return $stmt->execute([':id_usuario' => $id_usuario]);
    }
}
