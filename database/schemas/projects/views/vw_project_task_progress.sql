-- =============================================
-- Vista de Progresso de Tarefas por Projeto
-- =============================================
-- Descrição: 
-- Esta vista fornece métricas detalhadas sobre o progresso das tarefas em cada projeto.
-- Calcula o número de tarefas em cada estado e a percentagem de conclusão.
--
-- Campos Calculados:
-- total_tasks: Número total de tarefas
-- pending_tasks: Número de tarefas pendentes
-- in_progress_tasks: Número de tarefas em andamento
-- completed_tasks: Número de tarefas concluídas
-- completion_percentage: Percentagem de tarefas concluídas
-- =============================================

CREATE OR REPLACE VIEW projects.vw_project_task_progress AS
SELECT 
    p.id AS project_id,
    p.name AS project_name,
    COUNT(t.id) AS total_tasks,
    SUM(CASE WHEN t.status = 'pending' THEN 1 ELSE 0 END) AS pending_tasks,
    SUM(CASE WHEN t.status = 'in_progress' THEN 1 ELSE 0 END) AS in_progress_tasks,
    SUM(CASE WHEN t.status = 'completed' THEN 1 ELSE 0 END) AS completed_tasks,
    COALESCE(SUM(t.estimated_hours), 0) AS total_estimated_hours,
    COALESCE(SUM(tr.hours_worked), 0) AS total_actual_hours,
    CASE 
        WHEN COUNT(t.id) > 0 THEN 
            (SUM(CASE WHEN t.status = 'completed' THEN 100 ELSE 0 END) / COUNT(t.id))
        ELSE 0
    END AS completion_percentage
FROM 
    projects.tbl_projects p
    LEFT JOIN projects.tbl_tasks t ON t.project_id = p.id
    LEFT JOIN projects.tbl_task_regist tr ON tr.task_id = t.id
GROUP BY 
    p.id, p.name
ORDER BY 
    p.id;
