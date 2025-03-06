-- =============================================
-- Tabela de Registos de Tempo
-- =============================================
-- Descrição: 
-- Esta tabela armazena todos os registos de tempo trabalhado nas tarefas.
-- Cada registo associa um utilizador a uma tarefa com as horas trabalhadas.
--
-- Campos:
-- id: Identificador único do registo (auto-incremento)
-- task_id: ID da tarefa relacionada
-- user_id: ID do utilizador que trabalhou na tarefa
-- description: Descrição do trabalho realizado
-- hours_worked: Número de horas trabalhadas
-- date: Data do trabalho realizado
-- created_at: Data e hora de criação do registo
-- updated_at: Data e hora da última atualização
-- =============================================

-- Tabela: projects.tbl_task_regist
CREATE TABLE IF NOT EXISTS projects.tbl_task_regist (
    id SERIAL PRIMARY KEY,
    task_id INTEGER NOT NULL REFERENCES projects.tbl_tasks(id),
    user_id INTEGER NOT NULL REFERENCES auth.tbl_users(id),
    description TEXT,
    hours_worked DECIMAL(5,2) NOT NULL,
    date DATE NOT NULL DEFAULT CURRENT_DATE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Índices para otimização de consultas
CREATE INDEX IF NOT EXISTS idx_task_regist_task_id ON projects.tbl_task_regist(task_id);
CREATE INDEX IF NOT EXISTS idx_task_regist_user_id ON projects.tbl_task_regist(user_id);
CREATE INDEX IF NOT EXISTS idx_task_regist_date ON projects.tbl_task_regist(date);

-- Trigger para atualização automática do updated_at
CREATE OR REPLACE FUNCTION projects.update_task_regist_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_update_task_regist_timestamp
    BEFORE UPDATE ON projects.tbl_task_regist
    FOR EACH ROW
    EXECUTE FUNCTION projects.update_task_regist_updated_at();
