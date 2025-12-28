<?php
header("Content-Type: application/json; charset=UTF-8");
require_once __DIR__ . '/../config/db.php';

// CREATE COMPLETO
if ($_SERVER['REQUEST_METHOD'] === 'POST' && ($_GET['tipo'] ?? '') === 'completo') {
    $data = json_decode(file_get_contents("php://input"), true);

    $sql = "INSERT INTO denuncias (
                id_empresa, id_filial, atos_ilicitos, conduta, descumprimento_normas, 
                tipo_denuncia, sigilo_informacoes, protocolo, termo, email_notificacao,
                onde_ocorreu, quando_ocorreu, quem_cometeu, continua_ocorrendo,
                testemunhas, descreva_ocorrido, grau_certeza
            ) VALUES (
                :id_empresa, :id_filial, :atos_ilicitos, :conduta, :descumprimento_normas,
                :tipo_denuncia, :sigilo_informacoes, :protocolo, :termo, :email_notificacao,
                :onde_ocorreu, :quando_ocorreu, :quem_cometeu, :continua_ocorrendo,
                :testemunhas, :descreva_ocorrido, :grau_certeza
            )";

    $stmt = $pdo->prepare($sql);

    $ok = $stmt->execute([
        ':id_empresa'            => $data['id_empresa'],
        ':id_filial'             => $data['id_filial'] ?? null,
        ':atos_ilicitos'         => $data['atos_ilicitos'] ?? null,
        ':conduta'               => $data['conduta'] ?? null,
        ':descumprimento_normas' => $data['descumprimento_normas'] ?? null,
        ':tipo_denuncia'         => $data['tipo_denuncia'] ?? null,
        ':sigilo_informacoes'    => $data['sigilo_informacoes'] ?? null,
        ':protocolo'             => "DN-" . date("Y") . "-" . strtoupper(bin2hex(random_bytes(4))),
        ':termo'                 => $data['termo'] ?? 0,
        ':email_notificacao'     => $data['email_notificacao'] ?? null,
        ':onde_ocorreu'          => $data['onde_ocorreu'] ?? null,
        ':quando_ocorreu'        => $data['quando_ocorreu'] ?? null,
        ':quem_cometeu'          => $data['quem_cometeu'] ?? null,
        ':continua_ocorrendo'    => $data['continua_ocorrendo'] ?? null,
        ':testemunhas'           => $data['testemunhas'] ?? null,
        ':descreva_ocorrido'     => $data['descreva_ocorrido'] ?? null,
        ':grau_certeza'          => $data['grau_certeza'] ?? null
    ]);

    if ($ok) {
        echo json_encode([
            "success" => true,
            "id" => $pdo->lastInsertId()
        ]);
    } else {
        echo json_encode(["success" => false]);
    }
}
