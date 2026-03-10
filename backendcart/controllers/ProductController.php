<?php
class ProductController {
    private PDO $db;

    public function __construct(PDO $db) {
        $this->db = $db;
    }

    public function index(): void {
        $stmt = $this->db->query('SELECT * FROM products ORDER BY created_at DESC');
        ok($stmt->fetchAll());
    }

    public function show(int $id): void {
        $stmt = $this->db->prepare('SELECT * FROM products WHERE id = ?');
        $stmt->execute([$id]);
        $product = $stmt->fetch();
        if (!$product) fail('Product not found.', 404);
        ok($product);
    }
}