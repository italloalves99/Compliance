<?php
header("Content-Type: application/json; charset=UTF-8");
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

require_once __DIR__ . '/../config/db.php';
require_once __DIR__ . '/../src/Controllers/UserController.php';
require_once __DIR__ . '/../src/Models/User.php';

use Src\Controllers\UserController;

$controller = new UserController($pdo);

// Captura o método HTTP
$method = $_SERVER['REQUEST_METHOD'];

switch ($method) {
    case 'GET': // Listar todos
        echo json_encode($controller->getAll(), JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
        break;

    case 'POST': // Criar novo
        $data = json_decode(file_get_contents("php://input"), true);
        $ok = $controller->create(
            $data['id_empresa'],
            $data['nome'],
            $data['email'],
            $data['senha'],
            $data['perfil'],
            $data['status']
        );
        echo json_encode(['success' => $ok]);
        break;

    case 'PUT': // Atualizar
        $data = json_decode(file_get_contents("php://input"), true);
        $ok = $controller->update(
            $data['id_usuario'],
            $data['nome'],
            $data['email'],
            $data['senha'] ?? "",
            $data['perfil'],
            $data['status']
        );
        echo json_encode(['success' => $ok]);
        break;

    case 'DELETE': // Deletar
        $data = json_decode(file_get_contents("php://input"), true);
        $ok = $controller->delete($data['id_usuario']);
        echo json_encode(['success' => $ok]);
        break;

    default:
        http_response_code(405);
        echo json_encode(['error' => 'Método não permitido']);
        break;
}
