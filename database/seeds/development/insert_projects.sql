-- =============================================
-- Dados de Teste: Projetos
-- =============================================
-- Descrição: 
-- Este ficheiro insere dados de teste para projetos.
-- Cria projetos com diferentes características para testes.
--
-- Projetos criados:
-- 1. Website E-commerce (Projeto grande com taxa horária alta)
-- 2. App Mobile (Projeto médio em desenvolvimento)
-- 3. Landing Page (Projeto pequeno e rápido)
-- =============================================

INSERT INTO projects.tbl_projects (user_id, name, client_name, hourly_rate, status, created_at, updated_at)
VALUES 
(1, 'Website E-commerce', 'Loja Virtual SA', 75.00, 'active', NOW(), NOW()),
(2, 'App Mobile', 'Tech Solutions', 65.00, 'active', NOW(), NOW()),
(2, 'Landing Page', 'Startup XYZ', 50.00, 'active', NOW(), NOW()),
(3, 'Project 3', 'Client 3', 40.0, 'active', NOW(), NOW()),
(4, 'Project 4', 'Client 4', 50.0, 'active', NOW(), NOW()),
(5, 'Project 5', 'Client 5', 60.0, 'active', NOW(), NOW()),
(6, 'Project 6', 'Client 6', 70.0, 'active', NOW(), NOW()),
(7, 'Project 7', 'Client 7', 80.0, 'active', NOW(), NOW()),
(8, 'Project 8', 'Client 8', 90.0, 'active', NOW(), NOW()),
(9, 'Project 9', 'Client 9', 100.0, 'active', NOW(), NOW()),
(10, 'Project 10', 'Client 10', 110.0, 'active', NOW(), NOW());