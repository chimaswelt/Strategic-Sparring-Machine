-- ═══════════════════════════════════════════════════════
-- FRMTN Strategic Sparring Machine — Supabase Setup
-- Einmal ausführen im Supabase SQL Editor
-- ═══════════════════════════════════════════════════════

-- PROJECTS TABLE (custom projects, builtin sind im Code)
create table if not exists public.projects (
  id text primary key,
  name text not null,
  color text default '#c4401c',
  context text,
  tensions text[], -- array of "A vs. B" strings
  tension_values integer[],
  focus text,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

-- SESSIONS TABLE
create table if not exists public.sessions (
  id text primary key,
  project_id text not null,
  title text,
  mode text default 'sparring',
  history jsonb default '[]'::jsonb,
  msg_count integer default 0,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

-- INDEX für schnelle Abfragen nach Projekt
create index if not exists sessions_project_id_idx on public.sessions(project_id);
create index if not exists sessions_updated_at_idx on public.sessions(updated_at desc);

-- ROW LEVEL SECURITY (RLS) — Publishable Key darf lesen und schreiben
alter table public.projects enable row level security;
alter table public.sessions enable row level security;

-- Policies: vollständiger Zugriff mit Publishable Key (anon role)
create policy "allow_all_projects" on public.projects
  for all to anon using (true) with check (true);

create policy "allow_all_sessions" on public.sessions
  for all to anon using (true) with check (true);

-- Updated_at automatisch setzen
create or replace function public.set_updated_at()
returns trigger language plpgsql as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

create trigger projects_updated_at before update on public.projects
  for each row execute function public.set_updated_at();

create trigger sessions_updated_at before update on public.sessions
  for each row execute function public.set_updated_at();
