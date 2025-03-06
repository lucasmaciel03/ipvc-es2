-- =============================================
-- Tabela de Projetos
-- =============================================
-- Descrição: 
-- Esta tabela armazena informações sobre todos os projetos do sistema.
-- Cada projeto está associado a um cliente e tem uma taxa horária definida.
--
-- Campos:
-- id: Identificador único do projeto (auto-incremento)
-- user_id: ID do utilizador que criou o projeto
-- name: Nome do projeto
-- client_name: Nome do cliente
-- hourly_rate: Taxa horária cobrada no projeto
-- status: Estado atual do projeto (ativo, pausado, concluído, etc.)
-- created_at: Data e hora de criação do registo
-- updated_at: Data e hora da última atualização
-- =============================================

-- Tabela: projects.tbl_projects
CREATE TABLE IF NOT EXISTS projects.tbl_projects (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES auth.tbl_users(id),
    name VARCHAR(255) NOT NULL,
    client_name VARCHAR(255) NOT NULL,
    hourly_rate DECIMAL(10,2) NOT NULL,
    status VARCHAR(50) NOT NULL DEFAULT 'active',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_status CHECK (status IN ('active', 'inactive', 'completed', 'archived'))
);

-- Índices para otimização de consultas
CREATE INDEX IF NOT EXISTS idx_projects_user_id ON projects.tbl_projects(user_id);
CREATE INDEX IF NOT EXISTS idx_projects_status ON projects.tbl_projects(status);

-- Trigger para atualização automática do updated_at
CREATE OR REPLACE FUNCTION projects.update_projects_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_update_projects_timestamp
    BEFORE UPDATE ON projects.tbl_projects
    FOR EACH ROW
    EXECUTE FUNCTION projects.update_projects_updated_at();
