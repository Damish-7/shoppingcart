<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') { exit(); }

require_once __DIR__ . '/config/database.php';
require_once __DIR__ . '/helpers/response.php';
require_once __DIR__ . '/controllers/AuthController.php';
require_once __DIR__ . '/controllers/ProductController.php';

$uri    = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);
$uri = trim(preg_replace('#^/backendcart#', '', $uri), '/');
$parts  = explode('/', $uri);
$route  = $parts[0] ?? '';
$id     = isset($parts[1]) ? (int)$parts[1] : null;
$method = $_SERVER['REQUEST_METHOD'];
$body   = json_decode(file_get_contents('php://input'), true) ?? [];

$db = getDB();

try {
    switch ($route) {
        case 'login':
            if ($method === 'POST') (new AuthController($db))->login($body);
            else fail('Method not allowed.', 405);
            break;

        case 'register':
            if ($method === 'POST') (new AuthController($db))->register($body);
            else fail('Method not allowed.', 405);
            break;

        case 'products':
            $ctrl = new ProductController($db);
            if ($method === 'GET' && !$id)  $ctrl->index();
            elseif ($method === 'GET' && $id) $ctrl->show($id);
            else fail('Method not allowed.', 405);
            break;

        default:
            fail('Route not found.', 404);
    }
} catch (Exception $e) {
    fail('Server error: ' . $e->getMessage(), 500);
}
```

## File 16 — `shoppingcart/.htaccess`
```
Options -MultiViews
RewriteEngine On
RewriteCond %{REQUEST_FILENAME} !-f
RewriteRule ^ index.php [QSA,L]