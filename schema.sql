-- Green Room schema (v2 — multi-influencer)
-- Use this for a FRESH install.
-- If you already have tables, run schema_migration.sql instead.
-- SQL Editor → New query → paste → Run

create extension if not exists pgcrypto;

-- Influencers / Brand Bibles (one row per creator)
create table if not exists brand_bible (
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

-- Content Calendar
create table if not exists calendar_items (
  id uuid primary key default gen_random_uuid(),
  influencer_id uuid references brand_bible(id) on delete set null,
  take_number int,
  date date,
  platform text,
  title text,
  status text,
  notes text,
  created_at timestamptz default now()
);

-- Idea Bank
create table if not exists idea_bank (
  id uuid primary key default gen_random_uuid(),
  influencer_id uuid references brand_bible(id) on delete set null,
  take_number int,
  title text,
  platform text,
  notes text,
  stage text,
  created_at timestamptz default now()
);

-- Swipe File
create table if not exists swipe_file (
  id uuid primary key default gen_random_uuid(),
  influencer_id uuid references brand_bible(id) on delete set null,
  take_number int,
  title text,
  platform text,
  link text,
  notes text,
  tag text,
  created_at timestamptz default now()
);

-- Campaigns & Strategy
create table if not exists campaigns (
  id uuid primary key default gen_random_uuid(),
  influencer_id uuid references brand_bible(id) on delete set null,
  take_number int,
  title text,
  status text,
  timeframe text,
  channels text,
  notes text,
  created_at timestamptz default now()
);

-- Row Level Security
-- These policies allow full read/write to anyone holding the "anon" public key.
-- That's fine for a small trusted team sharing one link. See SETUP.md for notes
-- on tightening this later with Supabase Auth.
alter table brand_bible enable row level security;
alter table calendar_items enable row level security;
alter table idea_bank enable row level security;
alter table swipe_file enable row level security;
alter table campaigns enable row level security;

create policy "allow all brand_bible" on brand_bible for all using (true) with check (true);
create policy "allow all calendar_items" on calendar_items for all using (true) with check (true);
create policy "allow all idea_bank" on idea_bank for all using (true) with check (true);
create policy "allow all swipe_file" on swipe_file for all using (true) with check (true);
create policy "allow all campaigns" on campaigns for all using (true) with check (true);
