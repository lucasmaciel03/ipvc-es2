CREATE OR REPLACE VIEW projects.vw_user_project_hours AS
SELECT 
    u.id AS user_id,
    u.name AS user_name,
    u.daily_work_hours AS user_daily_target,
    p.id AS project_id,
    p.name AS project_name,
    pu.role AS user_role,
    COUNT(DISTINCT t.id) AS assigned_tasks,
    COALESCE(SUM(tr.hours_worked), 0) AS total_hours_worked,
    COUNT(DISTINCT tr.date) AS days_worked,
    COALESCE(ROUND(AVG(tr.hours_worked), 2), 0) AS avg_hours_per_day,
    MIN(tr.date) AS first_work_date,
    MAX(tr.date) AS last_work_date
FROM 
    auth.tbl_users u
    LEFT JOIN projects.tbl_project_users pu ON pu.user_id = u.id
    LEFT JOIN projects.tbl_projects p ON p.id = pu.project_id
    LEFT JOIN projects.tbl_tasks t ON t.project_id = p.id
    LEFT JOIN projects.tbl_task_regist tr ON tr.task_id = t.id AND tr.user_id = u.id
GROUP BY 
    u.id, u.name, u.daily_work_hours, p.id, p.name, pu.role
ORDER BY 
    u.id, p.id;
