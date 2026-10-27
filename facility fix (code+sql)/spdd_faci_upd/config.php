<?php
// FacilityFix database connection for XAMPP.
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}
date_default_timezone_set('Asia/Dhaka');

$dbHost = 'localhost';
$dbName = 'spdd_faci_upd';
$dbUser = 'root';
$dbPass = ''; // Default XAMPP MySQL password is blank.

try {
    $db = new PDO(
        "mysql:host={$dbHost};dbname={$dbName};charset=utf8mb4",
        $dbUser,
        $dbPass,
        [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
            PDO::ATTR_EMULATE_PREPARES => false
        ]
    );
} catch (Throwable $e) {
    http_response_code(500);
    die(
        '<!doctype html><html lang="en"><meta charset="utf-8"><title>Database connection</title>' .
        '<body style="font:16px Arial;padding:32px;max-width:760px;margin:auto">' .
        '<h2>FacilityFix database is not connected</h2>' .
        '<p>Start Apache and MySQL in XAMPP, then import <b>spdd_faci_upd.sql</b> in phpMyAdmin.</p>' .
        '<p>Expected database: <b>spdd_faci_upd</b></p>' .
        '<p>If your MySQL username or password is different, edit <code>config.php</code>.</p>' .
        '<details><summary>Technical detail</summary><pre>' . htmlspecialchars($e->getMessage(), ENT_QUOTES, 'UTF-8') . '</pre></details>' .
        '</body></html>'
    );
}
