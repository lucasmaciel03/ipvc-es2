-- =============================================
-- Tabela de Tarefas
-- =============================================
-- Descrição: 
-- Esta tabela armazena todas as tarefas associadas aos projetos.
-- Cada tarefa tem um estado e pode ter horas estimadas para conclusão.
--
-- Campos:
-- id: Identificador único da tarefa (auto-incremento)
-- project_id: ID do projeto ao qual a tarefa pertence
-- name: Nome da tarefa
-- description: Descrição detalhada da tarefa
-- status: Estado atual da tarefa (pendente, em progresso, concluída)
-- estimated_hours: Estimativa de horas necessárias para conclusão
-- created_at: Data e hora de criação do registo
-- updated_at: Data e hora da última atualização
-- =============================================

-- Tabela: projects.tbl_tasks
CREATE TABLE IF NOT EXISTS projects.tbl_tasks (
    id SERIAL PRIMARY KEY,
    project_id INTEGER NOT NULL REFERENCES projects.tbl_projects(id),
    name VARCHAR(255) NOT NULL,
    description TEXT,
    status VARCHAR(50) NOT NULL DEFAULT 'pending',
    estimated_hours INTEGER,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Índices para otimização de consultas
CREATE INDEX IF NOT EXISTS idx_tasks_project_id ON projects.tbl_tasks(project_id);
CREATE INDEX IF NOT EXISTS idx_tasks_status ON projects.tbl_tasks(status);

-- Trigger para atualização automática do updated_at
CREATE OR REPLACE FUNCTION projects.update_tasks_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_update_tasks_timestamp
    BEFORE UPDATE ON projects.tbl_tasks
    FOR EACH ROW
    EXECUTE FUNCTION projects.update_tasks_updated_at();
