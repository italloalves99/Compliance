<?php
session_start();

// se não tiver logado, redireciona
if (!isset($_SESSION['usuario_id'])) {
  header("Location: login.php");
  exit;
}

// se não for admin, bloqueia
if ($_SESSION['perfil'] !== 'admin') {
  echo "Acesso negado!";
  exit;
}

require_once __DIR__ . '/../config/db.php';

// busca todas as denúncias
$stmt = $pdo->query("SELECT id_denuncia, protocolo, status FROM denuncias ORDER BY created_at DESC");
$denuncias = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>
<!DOCTYPE html>
<html lang="pt-BR">

<head>
  <meta charset="UTF-8">
  <title>Painel - Compliance</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

  <link href="https://cdn.datatables.net/1.13.4/css/dataTables.bootstrap5.min.css" rel="stylesheet">

  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 0;
      background: #f3f4f6;
    }

    .sidebar {
      width: 220px;
      position: fixed;
      top: 0;
      left: 0;
      height: 100%;
      background: #1f2937;
      color: #f9fafb;
      transition: width 0.3s;
      overflow: hidden;
      display: flex;
      flex-direction: column;
      justify-content: space-between;
    }

    .sidebar .menu {
      flex-grow: 1;
    }

    .sidebar a {
      display: flex;
      align-items: center;
      gap: 10px;
      padding: 12px 20px;
      color: #f9fafb;
      text-decoration: none;
      white-space: nowrap;
      transition: 0.2s;
    }

    .sidebar a:hover {
      background: #848b99ff;
      color: #fff;
    }

    .sidebar.collapsed {
      width: 70px;
    }

    .sidebar.collapsed a span {
      display: none;
    }

    .content {
      margin-left: 220px;
      padding: 20px;
      transition: margin-left 0.3s;
      background: #f3f4f6;
      min-height: 100vh;
    }

    .content.collapsed {
      margin-left: 70px;
    }

    .hamburger {
      font-size: 22px;
      cursor: pointer;
      background: none;
      border: none;
      color: #f9fafb;
      margin: 15px;
    }

    .sidebar .bottom-link {
      margin-bottom: 20px;
    }

    table.dataTable thead {
      background: #959dadff;
      color: #fff;
    }

    table.dataTable tbody tr:nth-child(even) {
      background: #f9fafb;
    }

    table.dataTable tbody tr:nth-child(odd) {
      background: #ffffff;
    }
  </style>
</head>

<body>

  <div class="sidebar" id="sidebar">
    <div>
      <button class="hamburger" id="toggleSidebar"><i class="fas fa-bars"></i></button>
      <div class="menu">
        <a href="painel.php"><i class="fas fa-home"></i> <span>Dashboard</span></a>
      </div>
    </div>
    <div class="bottom-link">
      <a href="logout.php" class="text-danger"><i class="fas fa-sign-out-alt"></i> <span>Sair</span></a>
    </div>
  </div>

  <div class="content" id="content">
    <h3 class="mb-4">Lista de Denúncias</h3>
    <div class="table-responsive">
      <table id="tabelaDenuncias" class="table table-striped table-bordered align-middle">
        <thead>
          <tr>
            <th>ID</th>
            <th>Protocolo</th>
            <th>Status</th>
            <th>Ações</th>
          </tr>
        </thead>
        <tbody>
          <?php foreach ($denuncias as $d): ?>
            <tr>
              <td><?= htmlspecialchars($d['id_denuncia']) ?></td>
              <td><?= htmlspecialchars($d['protocolo']) ?></td>
              <td><?= htmlspecialchars($d['status']) ?></td>
              <td>
                <div class="dropdown">
                  <button class="btn btn-sm btn-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown">
                    Opções
                  </button>
                  <ul class="dropdown-menu">
                    <li>
                      <a class="dropdown-item" href="visualizar.php?id=<?= $d['id_denuncia'] ?>">
                        <i class="fas fa-eye"></i> Visualizar
                      </a>
                    </li>
                    <li>
                      <a class="dropdown-item" href="historico.php?id=<?= $d['id_denuncia'] ?>">
                        <i class="fas fa-history"></i> Histórico
                      </a>
                    </li>
                    <?php if ($d['status'] != 'concluida') { ?>
                      <li>
                        <a class="dropdown-item text-primary" href="atualizar.php?id=<?= $d['id_denuncia'] ?>">
                          <i class="fas fa-edit"></i> Atualizar Status
                        </a>
                      </li>
                    <?php } ?>
                    <li>
                      <a class="dropdown-item text-danger" href="excluir.php?id=<?= $d['id_denuncia'] ?>" onclick="return confirm('Deseja excluir esta denúncia?')">
                        <i class="fas fa-trash"></i> Excluir
                      </a>
                    </li>
                  </ul>


                </div>
              </td>
            </tr>
          <?php endforeach; ?>
        </tbody>
      </table>
    </div>
  </div>

  <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
  <script src="https://cdn.datatables.net/1.13.4/js/dataTables.bootstrap5.min.js"></script>

  <script>
    $(document).ready(function() {
      $('#tabelaDenuncias').DataTable({
        "language": {
          "url": "//cdn.datatables.net/plug-ins/1.13.4/i18n/pt-BR.json"
        },
        responsive: true
      });

      // botão hamburger
      $('#toggleSidebar').on('click', function() {
        $('#sidebar').toggleClass('collapsed');
        $('#content').toggleClass('collapsed');
      });
    });
  </script>
</body>

</html>