-- Table: projects.tbl_projects
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

-- Indexes
CREATE INDEX IF NOT EXISTS idx_projects_user_id ON projects.tbl_projects(user_id);
CREATE INDEX IF NOT EXISTS idx_projects_status ON projects.tbl_projects(status);

-- Trigger for updating updated_at timestamp
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
