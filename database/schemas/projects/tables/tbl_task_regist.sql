-- Table: projects.tbl_task_regist
CREATE TABLE IF NOT EXISTS projects.tbl_task_regist (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES auth.tbl_users(id),
    task_id UUID NOT NULL REFERENCES projects.tbl_tasks(id),
    time INTERVAL NOT NULL,
    date DATE NOT NULL,
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX IF NOT EXISTS idx_task_regist_user_id ON projects.tbl_task_regist(user_id);
CREATE INDEX IF NOT EXISTS idx_task_regist_task_id ON projects.tbl_task_regist(task_id);
CREATE INDEX IF NOT EXISTS idx_task_regist_date ON projects.tbl_task_regist(date);

-- Trigger for updating updated_at timestamp
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
