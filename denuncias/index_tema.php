<?php
session_start();
$idDenuncia = $_SESSION['denuncia_id'] ?? null;

if ($_SERVER['REQUEST_METHOD'] === 'POST' && $idDenuncia) {
    $temas = $_POST['tema'] ?? [];


    $data = [
        "id_denuncia"           => $idDenuncia,
        "atos_ilicitos"         => (array_intersect($temas, ["Fraude", "Corrupção", "Roubo ou Furto", "Conflito de Interesses"])) ? implode(",", array_intersect($temas, ["Fraude", "Corrupção", "Roubo ou Furto", "Conflito de Interesses"])) : null,
        "conduta"               => (array_intersect($temas, ["Assédio Moral", "Assédio Sexual", "Agressão Física", "Discriminação"])) ? implode(",", array_intersect($temas, ["Assédio Moral", "Assédio Sexual", "Agressão Física", "Discriminação"])) : null,
        "descumprimento_normas" => (array_intersect($temas, ["Políticas Internas", "Legislação Ambiental", "Legislação Trabalhista"])) ? implode(",", array_intersect($temas, ["Políticas Internas", "Legislação Ambiental", "Legislação Trabalhista"])) : null
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

        header("Location: detalhes_denuncia.php?id=" . urlencode($idDenuncia));
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
    <title>Seleção de Tema da Denúncia</title>
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

        .tema-card {
            border: 1px solid #dcdcdc;
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 15px;
            background: #fff;
        }

        .tema-card h6 {
            font-weight: bold;
            color: #2e4600;
            margin-bottom: 10px;
        }

        .form-check {
            border: 1px solid #c0c0c0;
            border-radius: 8px;
            padding: 10px;
            margin-bottom: 10px;
            background-color: #fff;
            display: flex;
            align-items: center;
            gap: 10px;
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


        .form-check-input {
            margin-left: 0 !important;
            position: static !important;
        }
    </style>
</head>

<body>

    <div class="container py-4">
        <div class="text-center mb-4">
            <img src="logo.png" alt="" class="logo">
            <h3 class="fw-bold">Selecione o Tema da Denúncia:</h3>
        </div>

        <form method="POST" action="">
            <!-- Grupo 1 -->
            <div class="tema-card">
                <h6>Atos ilícitos e conflitos de interesses</h6>
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" name="tema[]" value="Fraude" id="fraude">
                    <label class="form-check-label" for="fraude">Fraude</label>
                </div>
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" name="tema[]" value="Corrupção" id="corrupcao">
                    <label class="form-check-label" for="corrupcao">Corrupção</label>
                </div>
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" name="tema[]" value="Roubo ou Furto" id="roubo">
                    <label class="form-check-label" for="roubo">Roubo, Furto ou desvios de produtos</label>
                </div>
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" name="tema[]" value="Conflito de Interesses" id="conflito">
                    <label class="form-check-label" for="conflito">Conflito de Interesses</label>
                </div>
            </div>

            <!-- Grupo 2 -->
            <div class="tema-card">
                <h6>Conduta</h6>
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" name="tema[]" value="Assédio Moral" id="assedioMoral">
                    <label class="form-check-label" for="assedioMoral">Assédio Moral</label>
                </div>
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" name="tema[]" value="Assédio Sexual" id="assedioSexual">
                    <label class="form-check-label" for="assedioSexual">Assédio Sexual</label>
                </div>
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" name="tema[]" value="Agressão Física" id="agressao">
                    <label class="form-check-label" for="agressao">Agressão Física</label>
                </div>
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" name="tema[]" value="Discriminação" id="discriminacao">
                    <label class="form-check-label" for="discriminacao">Discriminação (Religiosa, Sexual ou Racial)</label>
                </div>
            </div>

            <!-- Grupo 3 -->
            <div class="tema-card">
                <h6>Descumprimento de Normas e Legislações</h6>
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" name="tema[]" value="Políticas Internas" id="politicas">
                    <label class="form-check-label" for="politicas">Políticas Internas</label>
                </div>
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" name="tema[]" value="Legislação Ambiental" id="ambiental">
                    <label class="form-check-label" for="ambiental">Legislação Ambiental</label>
                </div>
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" name="tema[]" value="Legislação Trabalhista" id="trabalhista">
                    <label class="form-check-label" for="trabalhista">Legislação Trabalhista</label>
                </div>
            </div>

            <div class="text-center mt-3">
                <button type="submit" class="btn btn-primary-custom text-white">Avançar</button>
            </div>
        </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <script>
        document.addEventListener("DOMContentLoaded", function() {
            const form = document.querySelector("form");
            const checkboxes = form.querySelectorAll(".form-check-input");

            // Só permite 1 selecionado no form inteiro
            checkboxes.forEach(chk => {
                chk.addEventListener("change", function() {
                    if (this.checked) {
                        checkboxes.forEach(cb => {
                            if (cb !== this) cb.checked = false;
                        });
                    }
                });
            });

            // Validação no submit (exige exatamente 1)
            form.addEventListener("submit", function(e) {
                const checked = form.querySelector(".form-check-input:checked");
                if (!checked) {
                    e.preventDefault();
                    Swal.fire({
                        icon: "warning",
                        title: "Atenção",
                        text: "Selecione um único tema para continuar.",
                        confirmButtonText: "Ok, entendi",
                        confirmButtonColor: "#6b8e23"
                    });
                }
            });
        });
    </script>


</body>

</html>