<?php
session_start();

$email = trim($_POST['email'] ?? '');
$senha = trim($_POST['senha'] ?? '');

// URL da API
$apiUrl = "http://aliancadev.com/compliance/api/users.php";

// Consome API
$json = file_get_contents($apiUrl);
$usuarios = json_decode($json, true);

// Garante que seja array
if (isset($usuarios['id_usuario'])) {
    $usuarios = [$usuarios];
}

// Procura usuário
$usuario = null;
foreach ($usuarios as $u) {
    if ($u['email'] === $email) {
        $usuario = $u;
        break;
    }
}

// Valida senha (se ainda não usa hash, use comparação simples)
if ($usuario && $senha === $usuario['senha']) {
    $_SESSION['usuario_id'] = $usuario['id_usuario'];
    $_SESSION['nome']       = $usuario['nome'];
    $_SESSION['perfil']     = $usuario['perfil'];

    header("Location: dashboard.php");
    exit;
} else {
    header("Location: login.php?erro=1");
    exit;
}
