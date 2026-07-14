# Green Room — Supabase + GitHub Pages setup

You need two things wired together: a Supabase project (the database) and a
GitHub repo with Pages turned on (the hosting). About 10 minutes total.

## 1. Create the Supabase project

1. Go to [supabase.com](https://supabase.com) and sign up (free tier is fine).
2. Click **New project**. Pick any name and password (you won't need the
   password day-to-day — just don't lose it).
3. Wait ~2 minutes for it to finish provisioning.

## 2. Create the tables

1. In your new project, open **SQL Editor** in the left sidebar.
2. Click **New query**.
3. Paste in the entire contents of `schema.sql` (included alongside this file).
4. Click **Run**. You should see "Success. No rows returned."
5. Open **Table Editor** to confirm you now have five tables: `brand_bible`,
   `calendar_items`, `idea_bank`, `swipe_file`, `campaigns`.

## 3. Get your API keys

1. In Supabase, go to **Settings → API**.
2. Copy the **Project URL** (looks like `https://abcdefgh.supabase.co`).
3. Copy the **anon public** key (a long string starting with `eyJ...`).

## 4. Connect the dashboard

1. Open `green-room-supabase.html` in a text editor.
2. Find this block near the top of the `<script type="module">` section:
   ```js
   const SUPABASE_URL = 'YOUR_SUPABASE_PROJECT_URL';
   const SUPABASE_ANON_KEY = 'YOUR_SUPABASE_ANON_KEY';
   ```
3. Replace both placeholders with the values from step 3, keeping the quotes.
4. Save the file.

You can now open the file directly in a browser (double-click it) to test —
no server needed. Add a calendar item or idea and check the Supabase Table
Editor to confirm rows are showing up there.

## 5. Put it on GitHub Pages

1. Create a new GitHub repository (public or private — Pages works with
   either, though private repos need a paid plan for Pages).
2. Rename `green-room-supabase.html` to `index.html` and upload it to the
   repo (you don't need to upload `schema.sql` or this file, but it's fine
   to keep them there for reference).
3. In the repo, go to **Settings → Pages**.
4. Under **Build and deployment → Source**, choose **Deploy from a branch**.
5. Choose the `main` branch and the `/ (root)` folder, then **Save**.
6. GitHub will give you a URL like
   `https://yourusername.github.io/your-repo-name/` — that's live in about a
   minute. Share that link with your team.

## Notes on security

The `anon` key is meant to be public-ish (it ships inside any client-side
app), but the RLS policies in `schema.sql` allow *anyone holding that key* to
read and write all five tables — there's no login. That's a reasonable
trade-off for a small team using one shared link, but:

- Don't post the GitHub Pages URL somewhere public.
- If you want real per-person accounts and access control later, Supabase
  has built-in Auth (email/password or magic links) — that's a follow-on
  step, not something you need to set up now.

## Updating the dashboard later

If you want changes to the layout, fields, or design down the line, just ask
me to edit `green-room-supabase.html` again and re-upload the new version to
your repo — the data itself lives in Supabase, so nothing is lost when you
swap the file.
