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
            <h6 class="fw-bold">Selecione o Tema da Denúncia:</h6>
        </div>

        <form method="POST" action="denuncia_passo2.php">
            <!-- Conduta -->
            <div class="tema-card">
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

            <!-- Normas e Legislação -->
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

            <!-- Sigilo -->
            <div class="tema-card">
                <h6>Sigilo de Informações</h6>
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" name="tema[]" value="Uso indevido de informações privilegiadas" id="usoIndevido">
                    <label class="form-check-label" for="usoIndevido">Uso indevido de informações privilegiadas</label>
                </div>
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" name="tema[]" value="Vazamento de dados confidenciais" id="vazamento">
                    <label class="form-check-label" for="vazamento">Vazamento de dados confidenciais</label>
                </div>
            </div>

            <div class="text-center mt-3">
                <button type="submit" class="btn btn-primary-custom text-white">Próximo</button>
            </div>
        </form>
    </div>

</body>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script>
document.addEventListener("DOMContentLoaded", function () {
    const form = document.querySelector("form");

    // Para cada bloco de tema-card
    document.querySelectorAll(".tema-card").forEach(card => {
        const checkboxes = card.querySelectorAll(".form-check-input");

        // Força comportamento de radio (só 1 marcado por grupo)
        checkboxes.forEach(chk => {
            chk.addEventListener("change", function () {
                if (this.checked) {
                    checkboxes.forEach(cb => {
                        if (cb !== this) cb.checked = false;
                    });
                }
            });
        });
    });

    // Validação no submit
    form.addEventListener("submit", function (e) {
        let valido = true;
        let mensagens = [];

        document.querySelectorAll(".tema-card").forEach((card, index) => {
            const checked = card.querySelector(".form-check-input:checked");
            if (!checked) {
                valido = false;
                mensagens.push(`Selecione pelo menos uma opção no grupo ${index + 1}`);
            }
        });

        if (!valido) {
            e.preventDefault();
            Swal.fire({
                icon: "warning",
                title: "Atenção",
                html: mensagens.join("<br>"),
                confirmButtonText: "Ok, entendi",
                confirmButtonColor: "#6b8e23"
            });
        }
    });
});
</script>

</html>