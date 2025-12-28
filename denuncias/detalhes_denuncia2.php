<?php
session_start();

// Pega id da denúncia já em andamento
$idDenuncia = $_SESSION['denuncia_id'] ?? ($_GET['id'] ?? null);

if ($_SERVER['REQUEST_METHOD'] === 'POST' && $idDenuncia) {
    $data = [
        "id_denuncia" => $idDenuncia,
        "protocolo"   => $_POST['protocolo'] ?? null
    ];

    $apiUrl = "https://aliancadev.com/compliance/api/denuncia.php";

    $options = [
        "http" => [
            "header"  => "Content-Type: application/json\r\n",
            "method"  => "PUT",
            "content" => json_encode($data),
        ],
    ];
    $context  = stream_context_create($options);
    $result   = file_get_contents($apiUrl, false, $context);
    $response = json_decode($result, true);

    if (!empty($response["success"])) {
        header("Location: termo.php?id=" . urlencode($idDenuncia));
        exit;
    } else {
        echo "<pre>Erro ao atualizar denúncia:\n";
        var_dump($result);
        echo "</pre>";
        exit;
    }
}
?>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <title>Detalhes da Denúncia</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      background-color: #f6faf6;
      font-family: Arial, sans-serif;
    }
    .logo {
      max-width: 120px;
      margin-bottom: 15px;
    }
    .form-section {
      border: 1px solid #dcdcdc;
      border-radius: 10px;
      padding: 20px;
      background: #fff;
    }
    .form-label {
      font-weight: 600;
      color: #2e4600;
    }
    .upload-box {
      border: 2px dashed #6b8e23;
      border-radius: 8px;
      padding: 20px;
      text-align: center;
      color: #6b8e23;
      cursor: pointer;
      background: #f9fff5;
    }
    .upload-box input {
      display: none;
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

<div class="container py-4">
  <div class="text-center mb-4">
    <!--<img src="logo.png" alt="Logo Empresa" class="logo">-->
    <h6 class="fw-bold">Detalhes da Denúncia:</h6>
  </div>

  <!-- action vazio = posta para o próprio arquivo -->
  <form method="POST" action="" enctype="multipart/form-data" class="form-section">
    <div class="mb-3">
      <label class="form-label">Você já denunciou anteriormente? Informe o protocolo</label>
      <input type="text" name="protocolo" class="form-control" placeholder="Ex: DN-2025-AB12CD34">
    </div>

    <!-- Upload de arquivos (deixa comentado por enquanto) -->
    <!--
    <div class="mb-3">
      <label class="form-label">Anexar arquivos (opcional)</label>
      <label class="upload-box">
        <i class="bi bi-cloud-upload" style="font-size: 2rem;"></i><br>
        <span>Escolher Arquivos<br><small>Máx. 1GB</small></span>
        <input type="file" name="arquivos[]" multiple>
      </label>
    </div>
    -->

    <div class="text-center mt-3">
      <button type="submit" class="btn btn-primary-custom text-white">Próximo</button>
    </div>
  </form>
</div>

<!-- Bootstrap icons (para o ícone de upload futuramente) -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

</body>
</html>
