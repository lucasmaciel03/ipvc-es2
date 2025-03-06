-- =============================================
-- Dados de Teste: Utilizadores
-- =============================================
-- Descrição: 
-- Este ficheiro insere dados de teste para utilizadores.
-- Útil para desenvolvimento e testes da aplicação.
--
-- Utilizadores criados:
-- 1. Lucas Maciel
-- 2. Andre Costa
-- 3. Joao Reis
-- 4. Manuel Vieira
-- 5. Duarte Silva
-- 6. Ricardo Silva
-- 7. Rui Silva
-- 8. Pedro Silva
-- 9. Jose Silva
-- 10. Carlos Silva
-- 11. Antonio Silva
-- =============================================

INSERT INTO auth.tbl_users (name, email, password, daily_work_hours, created_at, updated_at)
VALUES 
('Lucas Maciel', 'lucas.maciel@ipvc.pt', null, 8, NOW(), NOW()),
('Andre Costa', 'andre.costa@ipvc.pt', null, 6, NOW(), NOW()),
('Joao Reis', 'joao.reis@ipvc.pt', null, 4, NOW(), NOW()),
('Manuel Vieira', 'manuel.vieira@ipvc.pt', null, 3, NOW(), NOW()),
('Duarte Silva', 'duarte.silva@ipvc.pt', null, 9, NOW(), NOW()),
('Ricardo Silva', 'ricardo.silva@ipvc.pt', null, 12, NOW(), NOW()),
('Rui Silva', 'rui.silva@ipvc.pt', null, 2, NOW(), NOW()),
('Pedro Silva', 'pedro.silva@ipvc.pt', null, 3, NOW(), NOW()),
('Jose Silva', 'jose.silva@ipvc.pt', null, 6, NOW(), NOW()),
('Carlos Silva', 'carlos.silva@ipvc.pt', null, 7, NOW(), NOW()),
('Antonio Silva', 'antonio.silva@ipvc.pt', null, 3, NOW(), NOW());
