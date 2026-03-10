<?php
class AuthController {
    private PDO $db;

    public function __construct(PDO $db) {
        $this->db = $db;
    }

    public function login(array $body): void {
        $email    = trim($body['email']    ?? '');
        $password = trim($body['password'] ?? '');

        if (!$email || !$password) fail('Email and password are required.');

        $stmt = $this->db->prepare('SELECT * FROM users WHERE email = ?');
        $stmt->execute([$email]);
        $user = $stmt->fetch();

        if (!$user || !password_verify($password, $user['password'])) {
            fail('Invalid email or password.', 401);
        }

        $token = base64_encode($user['id'] . '|' . $user['email'] . '|' . time());
        unset($user['password']);
        ok(['token' => $token, 'user' => $user], 'Login successful');
    }

    public function register(array $body): void {
        $name     = trim($body['name']     ?? '');
        $email    = trim($body['email']    ?? '');
        $password = trim($body['password'] ?? '');

        if (!$name || !$email || !$password) fail('All fields are required.');
        if (!filter_var($email, FILTER_VALIDATE_EMAIL)) fail('Invalid email.');
        if (strlen($password) < 6) fail('Password must be at least 6 characters.');

        $stmt = $this->db->prepare('SELECT id FROM users WHERE email = ?');
        $stmt->execute([$email]);
        if ($stmt->fetch()) fail('Email already registered.', 409);

        $hash = password_hash($password, PASSWORD_BCRYPT);
        $stmt = $this->db->prepare('INSERT INTO users (name, email, password) VALUES (?, ?, ?)');
        $stmt->execute([$name, $email, $hash]);
        $userId = (int) $this->db->lastInsertId();

        $token = base64_encode($userId . '|' . $email . '|' . time());
        ok([
            'token' => $token,
            'user'  => ['id' => $userId, 'name' => $name, 'email' => $email],
        ], 'Registration successful');
    }
}