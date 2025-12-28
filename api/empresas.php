<?php
header("Content-Type: application/json; charset=UTF-8");
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

require_once __DIR__ . '/../config/db.php';
require_once __DIR__ . '/../src/Controllers/EmpresaController.php';
require_once __DIR__ . '/../src/Models/Empresa.php';

use Src\Controllers\EmpresaController;

$controller = new EmpresaController($pdo);

// Captura o método HTTP
$method = $_SERVER['REQUEST_METHOD'];

switch ($method) {
    case 'GET': // Listar todas
        echo json_encode($controller->getAll(), JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
        break;

    case 'POST': // Criar nova
        $data = json_decode(file_get_contents("php://input"), true);
        $ok = $controller->create(
            $data['nome'],
            $data['cnpj'],
            $data['email_principal'],
            $data['telefone'],
            $data['endereco'],
            $data['status']
        );
        echo json_encode(['success' => $ok]);
        break;

    case 'PUT': // Atualizar
        $data = json_decode(file_get_contents("php://input"), true);
        $ok = $controller->update(
            $data['id_empresa'],
            $data['nome'],
            $data['cnpj'],
            $data['email_principal'],
            $data['telefone'],
            $data['endereco'],
            $data['status']
        );
        echo json_encode(['success' => $ok]);
        break;

    case 'DELETE': // Deletar
        $data = json_decode(file_get_contents("php://input"), true);
        $ok = $controller->delete($data['id_empresa']);
        echo json_encode(['success' => $ok]);
        break;

    default:
        http_response_code(405);
        echo json_encode(['error' => 'Método não permitido']);
        break;
}
