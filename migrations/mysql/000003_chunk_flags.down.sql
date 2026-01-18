-- Migration: chunk_flags (rollback - MySQL)
-- Description: Remove flags column from chunks table

ALTER TABLE chunks DROP COLUMN IF EXISTS flags;
