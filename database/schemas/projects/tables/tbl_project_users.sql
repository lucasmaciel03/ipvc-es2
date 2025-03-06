-- Table: projects.tbl_project_users
CREATE TABLE IF NOT EXISTS projects.tbl_project_users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    project_id UUID NOT NULL REFERENCES projects.tbl_projects(id),
    user_id UUID NOT NULL REFERENCES auth.tbl_users(id),
    role VARCHAR(50) NOT NULL,
    joined_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    removed_at TIMESTAMP WITH TIME ZONE,
    CONSTRAINT unique_project_user UNIQUE (project_id, user_id),
    CONSTRAINT chk_role CHECK (role IN ('owner', 'admin', 'member', 'viewer'))
);

-- Indexes
CREATE INDEX IF NOT EXISTS idx_project_users_project_id ON projects.tbl_project_users(project_id);
CREATE INDEX IF NOT EXISTS idx_project_users_user_id ON projects.tbl_project_users(user_id);
CREATE INDEX IF NOT EXISTS idx_project_users_role ON projects.tbl_project_users(role);

-- Function to validate one owner per project
CREATE OR REPLACE FUNCTION projects.validate_project_owner()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.role = 'owner' THEN
        IF EXISTS (
            SELECT 1 FROM projects.tbl_project_users
            WHERE project_id = NEW.project_id 
            AND role = 'owner' 
            AND removed_at IS NULL
            AND id != COALESCE(NEW.id, '00000000-0000-0000-0000-000000000000'::UUID)
        ) THEN
            RAISE EXCEPTION 'Project can only have one owner';
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_validate_project_owner
    BEFORE INSERT OR UPDATE ON projects.tbl_project_users
    FOR EACH ROW
    EXECUTE FUNCTION projects.validate_project_owner();
