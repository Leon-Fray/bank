-- Green Room — Migration: single-influencer → multi-influencer (v2)
-- Run this in Supabase SQL Editor IF you already have the tables set up.
-- For a fresh install, use schema.sql instead.
--
-- ⚠️  WARNING: brand_bible will be DROPPED and recreated with UUID primary key.
--     Any existing brand bible data will be lost.
--     All calendar, idea, swipe, and campaign rows are preserved but will have
--     influencer_id = NULL until you reassign them in the app.

-- Step 1: Drop and recreate brand_bible with UUID support
-- (CASCADE removes any FK constraints that referenced the old brand_bible, if any)
drop table if exists brand_bible cascade;

create table brand_bible (
  id uuid primary key default gen_random_uuid(),
  influencer_name text,
  niche text,
  audience text,
  voice text,
  core_values text,
  pillars text,
  bio text,
  updated_at timestamptz default now()
);

alter table brand_bible enable row level security;
create policy "allow all brand_bible" on brand_bible for all using (true) with check (true);

-- Step 2: Add influencer_id to all content tables (nullable for backward compat)
alter table calendar_items
  add column if not exists influencer_id uuid references brand_bible(id) on delete set null;

alter table idea_bank
  add column if not exists influencer_id uuid references brand_bible(id) on delete set null;

alter table swipe_file
  add column if not exists influencer_id uuid references brand_bible(id) on delete set null;

alter table campaigns
  add column if not exists influencer_id uuid references brand_bible(id) on delete set null;
