<?php
function ok($data = null, string $msg = 'Success'): void {
    echo json_encode(['success' => true, 'message' => $msg, 'data' => $data]);
    exit();
}

function fail(string $msg = 'Error', int $code = 400): void {
    http_response_code($code);
    echo json_encode(['success' => false, 'message' => $msg]);
    exit();
}