-- =============================================
-- Vista de Resumo de Horas por Projeto
-- =============================================
-- Descrição: 
-- Esta vista fornece um resumo completo das horas e custos por projeto.
-- Inclui informações sobre horas estimadas, horas trabalhadas e custos.
--
-- Campos Calculados:
-- total_tasks: Número total de tarefas no projeto
-- total_estimated_hours: Total de horas estimadas para todas as tarefas
-- total_actual_hours: Total de horas efetivamente trabalhadas
-- total_cost: Custo total baseado nas horas trabalhadas e taxa horária
-- hours_variance: Diferença entre horas estimadas e realizadas
-- =============================================

CREATE OR REPLACE VIEW projects.vw_project_hours_summary AS
SELECT 
    p.id AS project_id,
    p.name AS project_name,
    p.client_name,
    p.hourly_rate,
    COUNT(DISTINCT t.id) AS total_tasks,
    COALESCE(SUM(t.estimated_hours), 0) AS total_estimated_hours,
    COALESCE(SUM(tr.hours_worked), 0) AS total_actual_hours,
    COALESCE(SUM(tr.hours_worked * p.hourly_rate), 0) AS total_cost,
    COALESCE(SUM(t.estimated_hours), 0) - COALESCE(SUM(tr.hours_worked), 0) AS hours_variance,
    COUNT(DISTINCT tr.id) AS total_time_entries,
    COUNT(DISTINCT tr.user_id) AS total_users,
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
