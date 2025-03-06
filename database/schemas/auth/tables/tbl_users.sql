-- Enable UUID extension
-- CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Create schema if not exists
CREATE SCHEMA IF NOT EXISTS auth;

-- Table: auth.tbl_users
CREATE TABLE IF NOT EXISTS auth.tbl_users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NULL UNIQUE,
    password VARCHAR(255) NULL,
    daily_work_hours INTEGER NOT NULL DEFAULT 8,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Index for email searches
CREATE INDEX IF NOT EXISTS idx_users_email ON auth.tbl_users(email);

-- Trigger for updating updated_at timestamp
CREATE OR REPLACE FUNCTION auth.update_users_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_update_users_timestamp
    BEFORE UPDATE ON auth.tbl_users
    FOR EACH ROW
    EXECUTE FUNCTION auth.update_users_updated_at();
