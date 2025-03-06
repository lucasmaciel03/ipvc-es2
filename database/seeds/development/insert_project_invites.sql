INSERT INTO projects.tbl_project_invites (id, project_id, user_id, role, status, created_at, updated_at)
VALUES (1, 1, 2, 'Developer', 'pending', NOW(), NOW()),
       (2, 2, 3, 'Developer', 'accepted', NOW(), NOW()),
       (3, 3, 4, 'Tester', 'rejected', NOW(), NOW()),
       (4, 4, 5, 'Designer', 'pending', NOW(), NOW()),
       (5, 5, 6, 'Developer', 'accepted', NOW(), NOW()),
       (6, 6, 7, 'Tester', 'rejected', NOW(), NOW()),
       (7, 7, 8, 'Designer', 'pending', NOW(), NOW()),
       (8, 8, 9, 'Developer', 'accepted', NOW(), NOW()),
       (9, 9, 10, 'Tester', 'rejected', NOW(), NOW()),
       (10, 10, 11, 'Designer', 'pending', NOW(), NOW());
