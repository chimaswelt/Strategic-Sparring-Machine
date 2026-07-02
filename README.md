# FRMTN — Strategic Sparring Machine

Ein KI-gestützter strategischer Sparringspartner für Cultural Strategy Studio FRMTN (Nico & Chima).

**Stack:** Statisches HTML · Supabase (Postgres) · GitHub Pages · Anthropic API

---

## Setup in 5 Schritten

### 1. Supabase — Tabellen anlegen

Im [Supabase SQL Editor](https://supabase.com/dashboard/project/gmttqlxqvqdukuspghoc/sql/new) die Datei `supabase_setup.sql` ausführen (copy-paste, dann Run).

Das erstellt:
- Tabelle `projects` — für custom Projekte
- Tabelle `sessions` — für alle Sparring-Sessions mit vollständiger History
- Row Level Security (RLS) Policies — Lese/Schreibzugriff mit Publishable Key
- Auto-updated_at Trigger

### 2. GitHub — Repo anlegen

```bash
# Neues Repo auf github.com anlegen: z.B. "sparring-machine"
# Dann lokal:
git init
git add index.html README.md supabase_setup.sql
git commit -m "initial: FRMTN strategic sparring machine"
git branch -M main
git remote add origin https://github.com/DEIN_USERNAME/sparring-machine.git
git push -u origin main
```

### 3. GitHub Pages aktivieren

Repo → Settings → Pages → Source: **Deploy from branch** → Branch: `main` → Folder: `/ (root)` → Save

Nach ~2 Minuten erreichbar unter:
`https://DEIN_USERNAME.github.io/sparring-machine/`

### 4. Fertig

Die App ist live. Supabase-Verbindung wird beim Start geprüft — Footer zeigt "Verbunden · Supabase" wenn alles ok ist.

---

## Nutzung

**Projekte:** Oben in der Leiste. DEMETER, TEMPLE LODGE, HUNGRIG, THE HUNDRED sind built-in. Neue Projekte über "+ Projekt" anlegen — werden in Supabase gespeichert und sind auf allen Geräten verfügbar.

**Sessions:** Pro Projekt eigene Session-Liste. Wird nach jeder AI-Antwort automatisch gespeichert. Neue Session über Sidebar.

**Modi:**
- ⚡ Strategisches Sparring — WHY-first, Golden Circle
- ◉ Blinde Flecken — Annahmen und Widersprüche aufdecken
- ○ WHY-Kern bohren — 5-Why-Technik für Markenidentität
- ⊗ Spannungen kartieren — produktive Spannungen dialektisch bearbeiten
- → Ableitungen entwickeln — aus Erkenntnissen WHY/HOW/WHAT ableiten

**Export:** Oben rechts → Markdown / Erkenntnisse / Offene Fragen → In Zwischenablage

---

## Supabase Credentials

```
Project URL:  https://gmttqlxqvqdukuspghoc.supabase.co
Project ID:   gmttqlxqvqdukuspghoc
Region:       eu-central-1 (Frankfurt)
```

> API Keys nicht im Repo commiten. Die Publishable Key ist im HTML hardcoded (sie ist für Browser-Zugriff ausgelegt), aber für ein öffentliches Repo besser als GitHub Secret + Build-Step handhaben.

---

## Datenstruktur

```sql
projects (id, name, color, context, tensions[], tension_values[], focus, created_at, updated_at)
sessions (id, project_id, title, mode, history jsonb, msg_count, created_at, updated_at)
```

---

*FRMTN space_available · Berlin 2026*
