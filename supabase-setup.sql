-- ====================================================
-- COLE ESSE CÓDIGO INTEIRO NO "SQL EDITOR" DO SUPABASE
-- E CLIQUE EM "RUN"
-- ====================================================

-- Tabela de perfis (usuários)
create table if not exists profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  nome text,
  email text,
  approved boolean default false,
  is_admin boolean default false,
  created_at timestamp default now()
);

-- Tabela de módulos
create table if not exists modules (
  id uuid primary key default gen_random_uuid(),
  titulo text not null,
  ordem int default 0,
  created_at timestamp default now()
);

-- Tabela de PDFs
create table if not exists pdfs (
  id uuid primary key default gen_random_uuid(),
  module_id uuid references modules(id) on delete cascade,
  titulo text not null,
  url text not null,
  ordem int default 0,
  created_at timestamp default now()
);

-- Ativar segurança por linha (RLS)
alter table profiles enable row level security;
alter table modules enable row level security;
alter table pdfs enable row level security;

-- Qualquer pessoa logada pode ver o PRÓPRIO perfil
create policy "ver_proprio_perfil" on profiles
  for select using (auth.uid() = id);

-- Qualquer pessoa logada pode criar o PRÓPRIO perfil (no cadastro)
create policy "criar_proprio_perfil" on profiles
  for insert with check (auth.uid() = id);

-- Só admin pode ver todos os perfis e aprovar/editar
create policy "admin_ve_tudo_perfis" on profiles
  for select using (
    exists (select 1 from profiles p where p.id = auth.uid() and p.is_admin = true)
  );

create policy "admin_edita_perfis" on profiles
  for update using (
    exists (select 1 from profiles p where p.id = auth.uid() and p.is_admin = true)
  );

create policy "admin_deleta_perfis" on profiles
  for delete using (
    exists (select 1 from profiles p where p.id = auth.uid() and p.is_admin = true)
  );

-- Módulos: qualquer usuário aprovado pode ver
create policy "ver_modulos_aprovados" on modules
  for select using (
    exists (select 1 from profiles p where p.id = auth.uid() and (p.approved = true or p.is_admin = true))
  );

-- Só admin pode criar/editar/excluir módulos
create policy "admin_gerencia_modulos" on modules
  for all using (
    exists (select 1 from profiles p where p.id = auth.uid() and p.is_admin = true)
  );

-- PDFs: mesma lógica dos módulos
create policy "ver_pdfs_aprovados" on pdfs
  for select using (
    exists (select 1 from profiles p where p.id = auth.uid() and (p.approved = true or p.is_admin = true))
  );

create policy "admin_gerencia_pdfs" on pdfs
  for all using (
    exists (select 1 from profiles p where p.id = auth.uid() and p.is_admin = true)
  );
