-- Enable UUID extension
-- CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- =============================================
-- Tabela de Utilizadores
-- =============================================
-- Descrição: 
-- Esta tabela armazena informações sobre todos os utilizadores do sistema.
-- Cada utilizador pode participar em vários projetos com diferentes funções.
--
-- Campos:
-- id: Identificador único do utilizador (auto-incremento)
-- name: Nome completo do utilizador
-- email: Endereço de email único do utilizador (opcional para flexibilidade de autenticação)
-- password: Palavra-passe do utilizador (opcional para permitir autenticação externa)
-- daily_work_hours: Número de horas de trabalho diárias previstas
-- created_at: Data e hora de criação do registo
-- updated_at: Data e hora da última atualização
-- =============================================

-- Criar schema se não existir
CREATE SCHEMA IF NOT EXISTS auth;

-- Tabela: auth.tbl_users
CREATE TABLE IF NOT EXISTS auth.tbl_users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NULL UNIQUE,
    password VARCHAR(255) NULL,
    daily_work_hours INTEGER NOT NULL DEFAULT 8,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Índice para pesquisas por email
CREATE INDEX IF NOT EXISTS idx_users_email ON auth.tbl_users(email);

-- Trigger para atualização automática do updated_at
CREATE OR REPLACE FUNCTION auth.update_users_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_update_users_timestamp
    BEFORE UPDATE ON auth.tbl_users
    FOR EACH ROW
    EXECUTE FUNCTION auth.update_users_updated_at();
