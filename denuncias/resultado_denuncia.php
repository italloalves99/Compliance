<?php
// resultado_denuncia.php
header("Content-Type: text/html; charset=UTF-8");
require_once __DIR__ . '/../config/db.php';

$protocolo = $_GET['protocolo'] ?? null;
$denuncia  = null;
$historicos = [];

if ($protocolo) {
    $stmt = $pdo->prepare("SELECT * FROM denuncias WHERE protocolo = ?");
    $stmt->execute([$protocolo]);
    $denuncia = $stmt->fetch(PDO::FETCH_ASSOC);

    if ($denuncia) {

        $stmtHist = $pdo->prepare("
            SELECT h.*, u.nome AS usuario 
            FROM denuncia_historico h
            LEFT JOIN usuarios u ON u.id_usuario = h.id_usuario
            WHERE h.id_denuncia = ?
            ORDER BY h.created_at ASC
        ");
        $stmtHist->execute([$denuncia['id_denuncia']]);
        $historicos = $stmtHist->fetchAll(PDO::FETCH_ASSOC);
    }
}
?>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <title>Acompanhar Denúncia</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      background-color: #f6faf6;
      font-family: Arial, sans-serif;
    }
    .card-custom {
      border: 1px solid #dcdcdc;
      border-radius: 10px;
      padding: 25px;
      background: #fff;
      box-shadow: 0 2px 6px rgba(0,0,0,0.08);
    }
    .status-box {
      border: 1px solid #6b8e23;
      border-radius: 8px;
      padding: 15px;
      font-size: 14px;
      text-align: left;
      margin-bottom: 20px;
      background: #f9fff5;
      color: #333;
    }
    .history-item {
      border-left: 4px solid #6b8e23;
      background: #fff;
      padding: 10px 15px;
      margin-bottom: 10px;
      border-radius: 6px;
      font-size: 14px;
      text-align: left;
    }
    .btn-primary-custom {
  background-color: #6b8e23;
  border-color: #6b8e23;
  width: 100%;
  color: #fff;
  transition: background-color 0.3s, transform 0.2s;
}

.btn-primary-custom:hover {
  background-color: #5a731d; 
  border-color: #5a731d;
  color: #fff;
  transform: translateY(-2px);
}

  </style>
</head>
<body>

<div class="container d-flex justify-content-center align-items-center vh-100">
  <div class="col-md-8 col-lg-6">
    <div class="card-custom text-center">
      <h6 class="fw-bold text-success mb-3">Acompanhar Denúncia</h6>

      <?php if ($denuncia): ?>

        <p class="mb-2">
          <strong>Protocolo:</strong>
          <span class="text-dark">
            <?= htmlspecialchars($denuncia['protocolo'], ENT_QUOTES, 'UTF-8') ?>
          </span>
        </p>

        <div class="status-box">
          <p><strong>Registrada em:</strong> <?= date('d/m/Y H:i', strtotime($denuncia['created_at'])); ?></p>
          <p><strong>Situação atual:</strong> <?= htmlspecialchars($denuncia['status'] ?? 'em_analise', ENT_QUOTES, 'UTF-8') ?></p>
        </div>

        <?php if (!empty($historicos)): ?>
          <h6 class="fw-bold text-secondary mb-3">Histórico de Atualizações</h6>
          <?php foreach ($historicos as $h): ?>
            <div class="history-item">
              <strong>Status:</strong> <?= htmlspecialchars($h['status']) ?><br>
              <small class="text-muted">
                <?= date('d/m/Y H:i', strtotime($h['created_at'])) ?>
                <?php if (!empty($h['usuario'])): ?>
                  - por <?= htmlspecialchars($h['usuario']) ?>
                <?php endif; ?>
              </small>
              <?php if (!empty($h['observacao'])): ?>
                <p class="mt-2 mb-0 text-muted"><?= nl2br(htmlspecialchars($h['observacao'])) ?></p>
              <?php endif; ?>
            </div>
          <?php endforeach; ?>
        <?php endif; ?>

      <?php else: ?>
        <div class="alert alert-danger">
          Protocolo não encontrado.
        </div>
      <?php endif; ?>

      <a href="denuncia_passo1.php" class="btn btn-primary-custom text-white mt-3">Voltar</a>
    </div>
  </div>
</div>

</body>
</html>
