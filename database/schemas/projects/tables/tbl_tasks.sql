-- Table: projects.tbl_tasks
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

-- Indexes
CREATE INDEX IF NOT EXISTS idx_tasks_project_id ON projects.tbl_tasks(project_id);
CREATE INDEX IF NOT EXISTS idx_tasks_status ON projects.tbl_tasks(status);

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
