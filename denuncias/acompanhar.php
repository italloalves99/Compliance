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
    .logo {
      max-width: 120px;
      margin-bottom: 15px;
    }
    .card-custom {
      border: 1px solid #dcdcdc;
      border-radius: 10px;
      padding: 25px;
      background: #fff;
      box-shadow: 0 2px 6px rgba(0,0,0,0.08);
    }
    .btn-primary-custom {
      background-color: #6b8e23;
      border-color: #6b8e23;
      width: 100%;
    }
  </style>
</head>
<body>

<div class="container d-flex justify-content-center align-items-center vh-100">
  <div class="col-md-6 col-lg-4">
    <div class="card-custom text-center">
      <!-- Logo -->
      <!--<img src="logo.png" alt="Logo" class="logo mx-auto d-block">-->

      <!-- Título -->
      <h6 class="fw-bold text-success mb-3">Acompanhar Denúncia</h6>

      <!-- Formulário -->
      <form method="GET" action="resultado_denuncia.php">
        <div class="mb-3 text-start">
          <label class="form-label">Qual o número de protocolo da sua denúncia? <span class="text-danger">*</span></label>
          <input type="text" name="protocolo" class="form-control" placeholder="Ex.: DN-2025-XYZ123" required>
        </div>

        <button type="submit" class="btn btn-primary-custom text-white">Consultar</button>
      </form>
    </div>
  </div>
</div>

</body>
</html>
