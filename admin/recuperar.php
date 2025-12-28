<?php
session_start();
date_default_timezone_set('America/Sao_Paulo');

// Config SMTP (você pode colocar no .env depois)
$MAIL_FROM     = 'contato@aliancedev.com';
$MAIL_FROMNAME = 'Compliance System';
$SMTP_HOST     = 'smtp.gmail.com';
$SMTP_PORT     = 587;
$SMTP_USER     = 'itallodev21@gmail.com';
$SMTP_PASS     = 'eqbizqqvccnxnjpl';
$SMTP_SECURE   = 'tls';

$mensagem = "";

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $email = trim($_POST['email']);

    if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        $mensagem = "<div class='alert alert-danger'>E-mail inválido</div>";
    } else {
        // Aqui você deveria verificar se o e-mail existe no banco
        // Por enquanto, vamos simular que existe e mandar o e-mail
        require_once __DIR__ . '/../vendor/autoload.php';

        try {
            $mail = new PHPMailer\PHPMailer\PHPMailer(true);
            $mail->CharSet = 'UTF-8';
            $mail->isSMTP();
            $mail->Host       = $SMTP_HOST;
            $mail->SMTPAuth   = true;
            $mail->Username   = $SMTP_USER;
            $mail->Password   = $SMTP_PASS;
            $mail->SMTPSecure = $SMTP_SECURE;
            $mail->Port       = $SMTP_PORT;

            $mail->setFrom($MAIL_FROM, $MAIL_FROMNAME);
            $mail->addAddress($email);

            $mail->isHTML(true);
            $mail->Subject = "Recuperação de senha - Compliance";
            $mail->Body    = "Olá,<br><br>Você solicitou a recuperação de senha.<br>
                              Clique no link abaixo para redefinir sua senha:<br>
                              <a href='http://aliancedev.com/compliance/admin/resetar.php?token=EXEMPLO123'>Redefinir Senha</a><br><br>
                              Caso não tenha solicitado, ignore este e-mail.";

            $mail->send();
            $mensagem = "<div class='alert alert-success'>E-mail de recuperação enviado! Verifique sua caixa de entrada.</div>";
        } catch (Exception $e) {
            $mensagem = "<div class='alert alert-danger'>Erro ao enviar e-mail: {$mail->ErrorInfo}</div>";
        }
    }
}
?>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <title>Recuperar Senha</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container d-flex justify-content-center align-items-center vh-100">
  <div class="card p-4 shadow" style="width: 400px;">
    <h3 class="text-center mb-3">Recuperar Senha</h3>

    <?= $mensagem ?>

    <form method="POST">
      <div class="mb-3">
        <label class="form-label">Digite seu e-mail</label>
        <input type="email" name="email" class="form-control" required>
      </div>
      <button type="submit" class="btn btn-primary w-100">Enviar</button>
    </form>

    <div class="mt-3 text-center">
      <a href="login.php">Voltar para o login</a>
    </div>
  </div>
</div>

</body>
</html>
