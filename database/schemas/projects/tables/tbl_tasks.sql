-- Table: projects.tbl_tasks
CREATE TABLE IF NOT EXISTS projects.tbl_tasks (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES auth.tbl_users(id),
    project_id UUID NOT NULL REFERENCES projects.tbl_projects(id),
    description TEXT NOT NULL,
    hourly_rate DECIMAL(10,2) NOT NULL,
    start_time TIMESTAMP WITH TIME ZONE NOT NULL,
    end_time TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT check_end_time CHECK (end_time IS NULL OR end_time > start_time)
);

-- Indexes
CREATE INDEX IF NOT EXISTS idx_tasks_user_id ON projects.tbl_tasks(user_id);
CREATE INDEX IF NOT EXISTS idx_tasks_project_id ON projects.tbl_tasks(project_id);
CREATE INDEX IF NOT EXISTS idx_tasks_start_time ON projects.tbl_tasks(start_time);
CREATE INDEX IF NOT EXISTS idx_tasks_end_time ON projects.tbl_tasks(end_time);

-- Trigger for updating updated_at timestamp
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
