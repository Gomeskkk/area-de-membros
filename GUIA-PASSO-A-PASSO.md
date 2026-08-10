# Guia — Área de Membros (do zero até publicado)

## PARTE 1 — Criar o banco de dados (Supabase)

1. Acesse **supabase.com** → crie uma conta grátis → **New Project**
2. Escolha um nome, uma senha para o banco (guarde essa senha) e a região mais próxima (South America)
3. Espere o projeto terminar de criar (leva ~2 minutos)
4. No menu lateral, clique em **SQL Editor** → **New query**
5. Abra o arquivo `supabase-setup.sql` (que te enviei), copie TUDO e cole ali
6. Clique em **Run** — isso cria as tabelas de usuários, módulos e PDFs automaticamente
7. Vá em **Project Settings** (ícone de engrenagem) → **API**
8. Copie dois valores:
   - **Project URL**
   - **anon public key**

## PARTE 2 — Colocar suas chaves no site

1. Abra o arquivo `config.js`
2. Troque:
   - `COLE_AQUI_SUA_SUPABASE_URL` pela Project URL
   - `COLE_AQUI_SUA_SUPABASE_ANON_KEY` pela anon public key
3. Salve o arquivo

## PARTE 3 — Subir seus PDFs

1. No Supabase, vá em **Storage** → **New bucket**
2. Nomeie como `pdfs` e marque como **Public bucket** (assim os links funcionam direto)
3. Clique em **Create bucket**
4. Faça upload de todos os seus PDFs ali dentro
5. Clique em cada arquivo → **Copy URL** — esse é o link que você vai colar no painel admin depois
   

## PARTE 4 — Publicar o site no Vercel

1. Crie uma conta em **vercel.com** (pode entrar com GitHub, Google ou e-mail)
2. Se ainda não tem, crie uma conta em **github.com**
3. No GitHub, crie um repositório novo (ex: `area-de-membros`)
4. Faça upload de TODOS os arquivos desta pasta para esse repositório
   (no GitHub dá pra usar "Add file → Upload files", sem precisar programar)
5. Volte no Vercel → **Add New → Project**
6. Selecione o repositório que você acabou de criar
7. Deixe tudo no padrão e clique em **Deploy**
8. Em menos de 1 minuto seu site estará no ar, em um link tipo:
   `https://area-de-membros-seunome.vercel.app`

## PARTE 5 — Criar SEU login master (admin)

1. Acesse o site publicado → vá em `/cadastro.html` → cadastre-se normalmente com seu e-mail
2. No Supabase, vá em **Table Editor** → tabela `profiles`
3. Encontre a linha com o seu e-mail
4. Edite manualmente e marque:
   - `approved` → `true`
   - `is_admin` → `true`
5. Salve

Pronto — agora quando você entrar com esse e-mail e senha, vai cair direto no **Painel Master** (`admin.html`), de onde você:
- aprova ou recusa novos cadastros
- cria módulos
- adiciona PDFs em cada módulo (colando o link copiado do Storage)

## Como funciona pro seu aluno

1. Aluno acessa `/cadastro.html`, cria conta com nome/e-mail/senha
2. Fica preso na tela "aguardando aprovação"
3. Você aprova ele no painel admin
4. Da próxima vez que ele fizer login, cai direto na área de membros, vendo os módulos liberados

## Se quiser um domínio próprio (ex: seudominio.com)

No painel do Vercel → **Settings → Domains** → adicione seu domínio comprado
(GoDaddy, Registro.br, Hostinger etc.) e siga as instruções de DNS que aparecem lá.

## Arquivos deste projeto

- `cadastro.html` — tela de cadastro do aluno
- `login.html` — tela de login
- `pendente.html` — tela de "aguardando aprovação"
- `membros.html` — área de membros com os módulos e PDFs
- `admin.html` — seu painel master
- `config.js` — onde ficam as chaves do Supabase
- `style.css` — visual do site (tema dark)
- `supabase-setup.sql` — script que cria o banco de dados
