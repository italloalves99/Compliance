<?php
return [

    // Ambiente
    'app_env'   => 'production', // ou development
    'app_debug' => true,

    // Banco de dados
    'db' => [
        'driver'   => 'mysql',
        'host'     => 'localhost',       // Em produção use localhost ou o IP do host
        'port'     => 3306,
        'database' => 'itallo69_compliance',
        'username' => 'itallo69_teste',
        'password' => 'itallo_99',
        'charset'  => 'utf8mb4',
    ],
];
