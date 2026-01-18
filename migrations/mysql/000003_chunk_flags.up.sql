-- Migration: chunk_flags (MySQL)
-- Description: Add flags column to chunks table for managing multiple boolean states

-- Add flags column with default value 1 (ChunkFlagRecommended)
-- This means all existing chunks will be recommended by default
-- Check and add column only if it doesn't exist
SET @column_exists = (
  SELECT COUNT(*)
  FROM information_schema.columns
  WHERE table_schema = DATABASE()
    AND table_name = 'chunks'
    AND column_name = 'flags'
);

SET @sql = IF(@column_exists = 0,
  'ALTER TABLE chunks ADD COLUMN flags INT NOT NULL DEFAULT 1',
  'SELECT "Column flags already exists" AS message'
);

PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
