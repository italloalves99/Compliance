<?php
session_start();

// Recupera ID da denúncia
$idDenuncia = $_SESSION['denuncia_id'] ?? ($_GET['id'] ?? null);

if ($_SERVER['REQUEST_METHOD'] === 'POST' && $idDenuncia) {
    $data = [
        "id_denuncia" => $idDenuncia,
        "termo"       => 1
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
        // Redireciona para página final de confirmação
        header("Location: sucesso.php?id=" . urlencode($idDenuncia));
        exit;
    } else {
        echo "<pre>Erro ao finalizar denúncia:\n";
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
  <title>Termo de Ciência - Denúncia</title>
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

    .termo-box {
      border: 1px solid #ccc;
      border-radius: 8px;
      padding: 15px;
      background: #fdfdfd;
      font-size: 14px;
      color: #333;
      margin-bottom: 15px;
      text-align: justify;
    }
  </style>
</head>
<body>

<div class="container py-4">
  <div class="text-center mb-4">
    <img src="logo.png" alt="" class="logo">
    <h6 class="fw-bold">Termo de Ciência</h6>
  </div>

  <form method="POST" action="" class="form-section">
    <div class="termo-box">
      Declaro a veracidade das informações prestadas sendo de minha responsabilidade.
      Estou ciente que as informações serão averiguadas durante o processo e as ações
      decorrentes serão tomadas conforme análise e critérios exclusivos e avaliados pela
      empresa <strong>EXXA</strong>. A empresa EXXA declara que as informações prestadas serão
      tratadas de forma confidencial, armazenadas e relatadas por tempo indeterminado para
      o processo de análise sobre a denúncia, atentando-se à legislação específica, mas
      não será exposto nenhum dado pessoal. <br><br>
      Ao selecionar o “Aceito” você indica ciência e concorda com as informações fornecidas.
    </div>

    <div class="form-check mb-3">
      <input class="form-check-input" type="checkbox" id="aceito" required>
      <label class="form-check-label" for="aceito">
        Declaro que li, compreendi as informações e desejo prosseguir.
      </label>
    </div>

    <div class="text-center mt-3">
      <button type="submit" class="btn btn-primary-custom text-white">Enviar Denúncia</button>
    </div>
  </form>
</div>

</body>
</html>
