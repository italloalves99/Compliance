<?php
session_start();

// ID pode vir da sessão ou da URL (segurança extra)
$idDenuncia = $_SESSION['denuncia_id'] ?? ($_GET['id'] ?? null);

if ($_SERVER['REQUEST_METHOD'] === 'POST' && $idDenuncia) {
    $data = [
        "id_denuncia"       => $idDenuncia,
        "onde_ocorreu"      => $_POST['local'] ?? null,
        "quando_ocorreu"    => $_POST['data_fato'] ?? null,
        "quem_cometeu"      => $_POST['autor'] ?? null,
        "continua_ocorrendo"=> $_POST['continua'] ?? null,
        "testemunhas"       => $_POST['testemunhas'] ?? null,
        "descreva_ocorrido" => $_POST['descricao'] ?? null,
        "grau_certeza"      => $_POST['certeza'] ?? null
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
        header("Location: detalhes_denuncia2.php?id=" . urlencode($idDenuncia));
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
    <h6 class="fw-bold">Detalhes da Denúncia:</h6>
  </div>

  <!-- action vazio: POSTa para o próprio arquivo -->
  <form method="POST" action="" class="form-section">
    <div class="mb-3">
      <label class="form-label">Onde ocorreu o incidente?</label>
      <input type="text" name="local" class="form-control" required>
    </div>

    <div class="mb-3">
      <label class="form-label">Quando esse fato ocorreu?</label>
      <input type="date" name="data_fato" class="form-control" placeholder="Ex: 10/01/2025" required>
    </div>

    <div class="mb-3">
      <label class="form-label">Quem cometeu o incidente? <small>(nome, sobrenome, área, cargo)</small></label>
      <input type="text" name="autor" class="form-control">
    </div>

    <div class="mb-3">
      <label class="form-label">Esse fato continua ocorrendo?</label>
      <!--<input type="text" name="continua" class="form-control" placeholder="Sim / Não">-->
      <select name="continua" id="" class="form-control">
        <option value=""></option>
        <option value="sim">Sim</option>
        <option value="nao">Nao</option>
      </select>
    </div>

    <div class="mb-3">
      <label class="form-label">Havia testemunhas?</label>
      <input type="text" name="testemunhas" class="form-control">
    </div>

    <div class="mb-3">
      <label class="form-label">Descreva com o maior nível de detalhes possível o ocorrido:</label>
      <textarea name="descricao" rows="5" class="form-control" required></textarea>
    </div>

    <div class="mb-3">
      <label class="form-label">Qual o grau de certeza sobre o fato?</label>
      <input type="text" name="certeza" class="form-control" placeholder="Ex: Alta, Média, Baixa">
    </div>

    <div class="text-center mt-3">
      <button type="submit" class="btn btn-primary-custom text-white">Próximo</button>
    </div>
  </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
document.addEventListener("DOMContentLoaded", function () {
    const form = document.querySelector("form");

    form.addEventListener("submit", function (e) {
        let erros = [];

        const local = form.querySelector("[name='local']").value.trim();
        const dataFato = form.querySelector("[name='data_fato']").value.trim();
        const descricao = form.querySelector("[name='descricao']").value.trim();

        if (!local) erros.push("Informe o local do incidente.");
        if (!dataFato) erros.push("Informe a data do fato.");
        if (!descricao) erros.push("Descreva o ocorrido em detalhes.");

        if (erros.length > 0) {
            e.preventDefault();
            Swal.fire({
                icon: "warning",
                title: "Atenção",
                html: erros.join("<br>"),
                confirmButtonText: "Ok, corrigir",
                confirmButtonColor: "#6b8e23"
            });
        }
    });
});
</script>
</body>
</html>
