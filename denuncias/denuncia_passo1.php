<?php
session_start();

if (isset($_GET['nova']) && $_GET['nova'] == 1) {
  $apiUrl = "https://aliancadev.com/compliance/api/denuncia.php";

  // Dados obrigatórios mínimos
  $data = [
    "id_empresa" => 1,
    "id_filial"  => null,
    "status"     => "pendente"
  ];

  $options = [
    "http" => [
      "header"  => "Content-Type: application/json\r\n",
      "method"  => "POST",
      "content" => json_encode($data),
      "ignore_errors" => true // captura até erros
    ],
  ];
  $context  = stream_context_create($options);
  $result   = file_get_contents($apiUrl, false, $context);

  // Debug temporário
  // echo "<pre>"; var_dump($result); exit;

  $response = json_decode($result, true);

  if (!empty($response["success"]) && $response["success"] === true) {
    $_SESSION["denuncia_id"] = $response["id"];
    header("Location: /compliance/denuncias/index_tema.php?id=" . $response["id"]);
    exit;
  } else {
    echo "<pre>Erro ao criar denúncia inicial. Resposta da API:\n";
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
  <title>Canal de Denúncia Anônima</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      background-color: #f9f9f9;
      font-family: Arial, sans-serif;
    }

    .logo {
      max-width: 120px;
      margin-bottom: 15px;
    }

    .card-custom {
      border: 1px solid #dcdcdc;
      border-radius: 10px;
      padding: 25px;
      text-align: center;
      background: #fff;
      box-shadow: 0 2px 6px rgba(0, 0, 0, 0.08);
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

    .btn-outline-custom {
      border: 1px solid #6b8e23;
      color: #6b8e23;
    }

    .btn-outline-custom:hover {
      background-color: #6b8e23;
      color: #fff;
    }
  </style>
</head>

<body>

  <div class="container d-flex justify-content-center align-items-center vh-100">
    <div class="col-md-6 col-lg-4">
      <div class="card-custom">
        <!-- Logo -->
        <img src="logo.png" alt="" class="logo mx-auto d-block">

        <!-- Título -->
        <h6 class="fw-bold text-success">CANAL DE DENÚNCIA ANÔNIMA</h6>

        <!-- Texto -->
        <p class="text-muted small">
          Esse portal é exclusivo da empresa <strong>EXXA</strong> para uma comunicação segura e anônima,
          de condutas inapropriadas e antiéticas, que violem princípios e/ou legislações vigentes.
          As informações serão registradas e tratadas conforme cada situação sem conflitos de interesses.
        </p>

        <!-- Botões -->
        <div class="d-grid gap-2 mt-3">
          <a href="?nova=1" class="btn btn-primary-custom" style="color: whitesmoke;">Iniciar a denúncia</a>
          <a href="acompanhar.php" class="btn btn-outline-custom">Acompanhar denúncia já realizada</a>
        </div>
      </div>
    </div>
  </div>

</body>

</html>