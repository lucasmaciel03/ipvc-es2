CREATE OR REPLACE VIEW projects.vw_project_hours_summary AS
SELECT 
    p.id AS project_id,
    p.name AS project_name,
    p.client_name,
    p.hourly_rate,
    COUNT(DISTINCT t.id) AS total_tasks,
    COUNT(DISTINCT tr.id) AS total_time_entries,
    COUNT(DISTINCT tr.user_id) AS total_users,
    COALESCE(SUM(tr.hours_worked), 0) AS total_hours_worked,
    COALESCE(SUM(tr.hours_worked * p.hourly_rate), 0) AS total_cost,
    MIN(tr.date) AS first_time_entry,
    MAX(tr.date) AS last_time_entry
FROM 
    projects.tbl_projects p
    LEFT JOIN projects.tbl_tasks t ON t.project_id = p.id
    LEFT JOIN projects.tbl_task_regist tr ON tr.task_id = t.id
GROUP BY 
    p.id, p.name, p.client_name, p.hourly_rate
ORDER BY 
    p.id;
