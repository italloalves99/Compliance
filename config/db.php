<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

$config = [
    'app_env'   => 'production', 
    'app_debug' => true,

    'db' => [
        'driver'   => 'mysql',
        'host'     => 'localhost',   
        'port'     => 3306,
        'database' => 'compliance',
        'username' => 'root',
        'password' => '',
        'charset'  => 'utf8mb4',
    ],
];

try {
    $dbConfig = $config['db'];

    $dsn = sprintf(
        "%s:host=%s;port=%d;dbname=%s;charset=%s",
        $dbConfig['driver'],
        $dbConfig['host'],
        $dbConfig['port'],
        $dbConfig['database'],
        $dbConfig['charset']
    );

    $pdo = new PDO($dsn, $dbConfig['username'], $dbConfig['password'], [
        PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
        PDO::ATTR_EMULATE_PREPARES   => false,
    ]);

// echo "Conectado com sucesso ao banco de dados!";

} catch (PDOException $e) {
    die("Erro ao conectar ao banco: " . $e->getMessage());
}
