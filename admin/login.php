<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <title>Login - Compliance</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container d-flex justify-content-center align-items-center vh-100">
  <div class="card p-4 shadow" style="width: 350px;">
    <h3 class="text-center mb-3">Compliance Login</h3>

    <?php if (isset($_GET['erro'])): ?>
      <div class="alert alert-danger">E-mail ou senha inválidos!</div>
    <?php endif; ?>

    <form method="POST" action="verifica_login.php">
      <div class="mb-3">
        <label class="form-label">E-mail</label>
        <input type="email" name="email" class="form-control" required>
      </div>
      <div class="mb-3">
        <label class="form-label">Senha</label>
        <input type="password" name="senha" class="form-control" required>
      </div>
      <div class="md-3">
        <a href="recuperar.php" style="text-decoration: none;">Esqueceu a Senha:</a>
      </div>
      <button type="submit" class="btn btn-primary w-100">Entrar</button>
    </form>
  </div>
</div>

</body>
</html>
