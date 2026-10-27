<?php
// Shared security notes for the project. Main form handlers use CSRF tokens and PDO prepared statements.
if (!function_exists('safe_output')) { function safe_output($value) { return htmlspecialchars((string)$value, ENT_QUOTES, 'UTF-8'); } }
