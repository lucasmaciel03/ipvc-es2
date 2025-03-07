CREATE SCHEMA IF NOT EXISTS projects;

-- Table: projects.tbl_project_invites
CREATE TABLE IF NOT EXISTS projects.tbl_project_invites (
    id SERIAL PRIMARY KEY,
    project_id INTEGER NOT NULL REFERENCES projects.tbl_projects(id),
    user_id INTEGER NOT NULL REFERENCES auth.tbl_users(id),
    role VARCHAR(50) NOT NULL,
    status VARCHAR(50) NOT NULL DEFAULT 'pending',
    invited_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    responded_at TIMESTAMP WITH TIME ZONE DEFAULT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(project_id, user_id)
);

-- Indexes
CREATE INDEX IF NOT EXISTS idx_project_invites_project_id ON projects.tbl_project_invites(project_id);
CREATE INDEX IF NOT EXISTS idx_project_invites_user_id ON projects.tbl_project_invites(user_id);
CREATE INDEX IF NOT EXISTS idx_project_invites_status ON projects.tbl_project_invites(status);

-- Trigger for updating updated_at timestamp
CREATE OR REPLACE FUNCTION projects.update_project_invites_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_update_project_invites_timestamp
    BEFORE UPDATE ON projects.tbl_project_invites
    FOR EACH ROW
    EXECUTE FUNCTION projects.update_project_invites_updated_at();
