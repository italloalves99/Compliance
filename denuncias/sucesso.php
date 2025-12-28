<?php
// denuncia_enviar.php
session_start();

// Recupera ID vindo da sessão ou query string
$idDenuncia = $_SESSION['denuncia_id'] ?? ($_GET['id'] ?? null);
$protocolo = null;

if ($idDenuncia) {
    // Consulta API para pegar protocolo
    $apiUrl = "https://aliancadev.com/compliance/api/denuncia.php?id=" . urlencode($idDenuncia);
    $result = file_get_contents($apiUrl);
    $response = json_decode($result, true);

    if (!empty($response["protocolo"])) {
        $protocolo = $response["protocolo"];
    }
}
?>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <title>Denúncia Enviada - Sucesso</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      background-color: #f6faf6;
      font-family: Arial, sans-serif;
    }
    .logo {
      max-width: 120px;
      margin-bottom: 20px;
    }
    .card-success {
      background: #fff;
      border: 1px solid #dcdcdc;
      border-radius: 10px;
      padding: 30px;
      text-align: center;
    }
    .protocolo {
      display: inline-block;
      border: 1px solid #6b8e23;
      color: #2e4600;
      font-weight: bold;
      padding: 10px 20px;
      border-radius: 6px;
      margin: 15px 0;
      background: #f9fff5;
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

    .btn-copy {
      margin-top: 10px;
      background-color: #fff;
      border: 1px solid #6b8e23;
      color: #6b8e23;
      font-size: 14px;
      padding: 5px 15px;
      border-radius: 6px;
    }
    .btn-copy:hover {
      background-color: #6b8e23;
      color: #fff;
    }
  </style>
</head>
<body>

<div class="container d-flex justify-content-center align-items-center vh-100">
  <div class="card-success shadow-sm">
    <div class="text-center">
      <!--<img src="logo.png" alt="Logo Empresa" class="logo">-->
      <h6 class="fw-bold text-success">Sua denúncia foi enviada com sucesso.</h6>
      <p class="text-muted">
        Guarde o código abaixo para acompanhar o status no nosso site.
      </p>
      <div class="protocolo" id="protocolo-text">
        <?= htmlspecialchars($protocolo ?? 'N/A', ENT_QUOTES, 'UTF-8'); ?>
      </div>
      <br>
      <button type="button" class="btn-copy" onclick="copiarProtocolo()">📋 Copiar código</button>
      <form action="denuncia_passo1.php" method="get" class="mt-3">
        <button type="submit" class="btn btn-primary-custom">Concluir</button>
      </form>
    </div>
  </div>
</div>

<script>
function copiarProtocolo() {
    const text = document.getElementById("protocolo-text").innerText;
    navigator.clipboard.writeText(text).then(() => {
        alert("Protocolo copiado: " + text);
    }).catch(err => {
        alert("Erro ao copiar: " + err);
    });
}
</script>

</body>
</html>
