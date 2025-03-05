# Migration Versions

Este diretório contém as versões das migrações da base de dados.

Características:
- Migrações sequenciais numeradas
- Formato: YYYYMMDDHHMMSS_descricao.sql
- Cada migração contém:
  - Alterações no schema (up)
  - Rollback das alterações (down)
  - Comentários descritivos
  - Dependências entre migrações
