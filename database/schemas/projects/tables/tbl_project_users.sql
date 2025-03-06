-- Table: projects.tbl_project_users
CREATE TABLE IF NOT EXISTS projects.tbl_project_users (
    id SERIAL PRIMARY KEY,
    project_id INTEGER NOT NULL REFERENCES projects.tbl_projects(id),
    user_id INTEGER NOT NULL REFERENCES auth.tbl_users(id),
    role VARCHAR(50) NOT NULL,
    joined_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    removed_at TIMESTAMP WITH TIME ZONE DEFAULT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(project_id, user_id)
);

-- Indexes
CREATE INDEX IF NOT EXISTS idx_project_users_project_id ON projects.tbl_project_users(project_id);
CREATE INDEX IF NOT EXISTS idx_project_users_user_id ON projects.tbl_project_users(user_id);
CREATE INDEX IF NOT EXISTS idx_project_users_role ON projects.tbl_project_users(role);

-- Trigger for updating updated_at timestamp
CREATE OR REPLACE FUNCTION projects.update_project_users_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_update_project_users_timestamp
    BEFORE UPDATE ON projects.tbl_project_users
    FOR EACH ROW
    EXECUTE FUNCTION projects.update_project_users_updated_at();
