<?php
session_start();

// Proteção de acesso
if (!isset($_SESSION['usuario_id'])) {
    header("Location: login.php");
    exit;
}
if ($_SESSION['perfil'] !== 'admin' && $_SESSION['perfil'] !== 'auditoria') {
    echo "Acesso negado!";
    exit;
}

require_once __DIR__ . '/../config/db.php';

// Labels
$statusLabels = [
    'pendente'   => 'Pendente',
    'em_analise' => 'Em Análise',
    'concluida'  => 'Concluída'
];

// Pega id
$id = $_GET['id'] ?? null;
if (!$id) {
    die("ID inválido.");
}

// Busca denúncia
$stmt = $pdo->prepare("SELECT * FROM denuncias WHERE id_denuncia = ?");
$stmt->execute([$id]);
$denuncia = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$denuncia) {
    die("Denúncia não encontrada.");
}

// Atualiza se post
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $status = $_POST['status'] ?? 'pendente';
    $observacao = $_POST['observacao'] ?? null;

    try {
        $pdo->beginTransaction();

        // UPDATE na denuncia
        $stmt = $pdo->prepare("UPDATE denuncias SET status = :status, updated_at = NOW() WHERE id_denuncia = :id");
        $stmt->execute([
            ':status' => $status,
            ':id'     => $id
        ]);

        // INSERT no histórico
        $stmtHist = $pdo->prepare("INSERT INTO denuncia_historico (id_denuncia, id_usuario, status, observacao) 
                                   VALUES (:id_denuncia, :id_usuario, :status, :observacao)");
        $stmtHist->execute([
            ':id_denuncia' => $id,
            ':id_usuario'  => $_SESSION['usuario_id'],
            ':status'      => $status,
            ':observacao'  => $observacao
        ]);

        $pdo->commit();

        header("Location: dashboard.php?msg=atualizado");
        exit;

    } catch (Exception $e) {
        $pdo->rollBack();
        $erro = "Erro ao atualizar denúncia: " . $e->getMessage();
    }
}
?>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <title>Atualizar Denúncia</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      background-color: #f6faf6;
      font-family: Arial, sans-serif;
    }
    .card-custom {
      max-width: 600px;
      margin: 30px auto;
      padding: 20px;
      border-radius: 10px;
      background: #fff;
      box-shadow: 0 3px 8px rgba(0,0,0,0.1);
    }
    .btn-primary-custom {
      background-color: #6b8e23;
      border-color: #6b8e23;
    }
    .btn-primary-custom:hover {
      background-color: #557017;
      border-color: #557017;
    }
  </style>
</head>
<body>
<div class="container">
  <div class="card-custom">
    <h4 class="mb-3">Atualizar Denúncia</h4>

    <?php if (!empty($erro)): ?>
      <div class="alert alert-danger"><?= htmlspecialchars($erro) ?></div>
    <?php endif; ?>

    <form method="POST" action="">
      <div class="mb-3">
        <label class="form-label">Protocolo</label>
        <input type="text" class="form-control" value="<?= htmlspecialchars($denuncia['protocolo']) ?>" disabled>
      </div>

      <div class="mb-3">
        <label class="form-label">Status da Denúncia</label>
        <select class="form-select" name="status" required>
          <?php foreach ($statusLabels as $value => $label): ?>
            <option value="<?= $value ?>" <?= $denuncia['status'] === $value ? 'selected' : '' ?>>
              <?= $label ?>
            </option>
          <?php endforeach; ?>
        </select>
      </div>

      <div class="mb-3">
        <label class="form-label">Observação (opcional)</label>
        <textarea name="observacao" class="form-control" rows="3"></textarea>
      </div>

      <div class="text-end">
        <a href="dashboard.php" class="btn btn-secondary">Cancelar</a>
        <button type="submit" class="btn btn-primary-custom text-white">Salvar Alterações</button>
      </div>
    </form>
  </div>
</div>
</body>
</html>
