// ====================================================
// CONFIGURAÇÃO DO SUPABASE
// Troque os valores abaixo pelos dados do SEU projeto Supabase
// (você pega isso em: Project Settings > API)
// ====================================================
const SUPABASE_URL = "https://drlmrqgqauzbrderovik.supabase.co";
const SUPABASE_ANON_KEY = "sb_publishable_dsB7BBKNrGI5_2giTw0Irg_HIvOPeF9";

const supabaseClient = window.supabase.createClient(SUPABASE_URL, SUPABASE_ANON_KEY);
