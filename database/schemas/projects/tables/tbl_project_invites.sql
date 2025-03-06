-- Table: auth.tbl_project_invites
CREATE TABLE IF NOT EXISTS auth.tbl_project_invites (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    project_id UUID NOT NULL REFERENCES auth.tbl_projects(id),
    invited_user_id UUID NOT NULL REFERENCES auth.tbl_users(id),
    status VARCHAR(50) NOT NULL DEFAULT 'pending',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT unique_project_invite UNIQUE (project_id, invited_user_id),
    CONSTRAINT chk_invite_status CHECK (status IN ('pending', 'accepted', 'rejected', 'expired'))
);

-- Indexes
CREATE INDEX IF NOT EXISTS idx_project_invites_project_id ON auth.tbl_project_invites(project_id);
CREATE INDEX IF NOT EXISTS idx_project_invites_invited_user_id ON auth.tbl_project_invites(invited_user_id);
CREATE INDEX IF NOT EXISTS idx_project_invites_status ON auth.tbl_project_invites(status);

-- Trigger for updating updated_at timestamp
CREATE OR REPLACE FUNCTION auth.update_project_invites_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_update_project_invites_timestamp
    BEFORE UPDATE ON auth.tbl_project_invites
    FOR EACH ROW
    EXECUTE FUNCTION auth.update_project_invites_updated_at();
