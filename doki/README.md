# doki 🫀

> Your daily note, with a heartbeat.

`doki` is a tiny CLI tool that helps you capture topic-based notes effortlessly — one heartbeat at a time. Just run `doki <topic>`, and it will create (or open) a markdown note for today under that topic. No friction. Just your thoughts, timestamped.

The name **“doki”** comes from the Japanese onomatopoeia for a heartbeat — ドキ (doki). Because your notes should feel alive, pulsing with the rhythm of your day.

---

## ✨ Features

- 🗂 Topic-based organization
- 📅 Automatically dates your notes (YYYY-MM-DD)
- 📝 Smart: opens existing note for today if one exists
- ⚡ Fast and intuitive — just run `doki <topic>`
- 🧠 Powered by your favorite editor (defaults to `nvim`)

---

## 🚀 Usage

```bash
doki <topic>
````

Example:

```bash
doki rust-notes
doki daily-reflection
```

This will open (or create) the note:

```
~/notes/rust-notes/2025-07-26.md
```

### 🔧 Optional Flags

* `-n` or `--new` – create a new note even if today's exists
* `-e` or `--editor` – override the default editor

---

## 🛠 Setup

1. Copy the `doki` script to a directory in your `PATH` (e.g. `~/bin/`)
2. Make it executable:

```bash
chmod +x ~/bin/doki
```

3. (Optional) Add a shortcut alias:

```bash
alias d='doki'
```

---

## 🖋 Default Template

Each note begins with:

```markdown
# <Topic Title>
📅 <Date>
---
```

You can customize the template if needed inside the script.

---

## 💡 Ideas for Use

* Daily dev logs (`doki dev-log`)
* Journaling (`doki journal`)
* Study notes (`doki algorithms`)
* Brain dumps (`doki ideas`)
* Topic-specific logs (`doki flutter`)

---

## 🧠 Philosophy

> *One thought, one note, one heartbeat.*

`doki` is meant to be the lightest touchpoint between you and your ideas. No folders to create. No file names to think up. Just your topic — and today's rhythm.

---

## 📦 License

MIT

