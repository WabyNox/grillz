# GRILLZ 🔥 — Hack the Kitchen

**Grillz** is a CLI *command cooker* for offensive security.  
It lets you keep pentesting cheatsheets in Markdown, search them via `fzf`, and "cook" commands interactively by filling `<vars>` on the fly.

Recipes are grouped by **tool** (one file per tool) but titled by **pentest phase**, so you can search naturally by attack step instead of remembering syntax.

```
# [Recon] Subdomain brute-force --ffuf
ffuf -u http://FUZZ.<domain>/ -w <wordlist>
```

---

## ✨ Features

- 🎮 Quick menu at startup, navigable with arrows
- 🔎 Fuzzy search (`fzf`) across all recipes, extended matching by default.  
- 🧩 Markdown-based recipes with `<vars>` placeholders.  
- 🍳 Interactive cooking: fill variables step by step, preview current mix.  
- ⚡ Modes:
  - `--run` (default): execute final command immediately.
  - `--print`: print only, no execution.
  - `--quiet`: minimal prompts, no banner.  
- 🧰 Built-in admin commands: `install | uninstall | link | unlink | doctor | paths`.  
- 🧠 Modular code layout, plugin-friendly.  
- 📂 Recipes organized by **tools** and **shared snippets**.

---

## 📦 Install

### User-local (~/.local)
```bash
PREFIX="$HOME/.local" ./bin/grillz install
# ensure ~/.local/bin is in PATH
```

### System-wide (/usr/local)
```bash
sudo PREFIX=/usr/local ./bin/grillz install
```

### Uninstall
```bash
grillz uninstall
```

### Doctor
Check your installation and config folders:
```bash
grillz doctor
```

---

## ⌨️ Shell Completions

### Bash
```bash
echo 'source ~/.local/lib/grillz-completions/grillz.bash' >> ~/.bashrc
exec bash
```

### Zsh
```zsh
echo 'fpath=("$HOME/.local/lib/grillz-completions" $fpath)' >> ~/.zshrc
echo 'autoload -Uz compinit && compinit' >> ~/.zshrc
exec zsh
```

---

## 🗂 Pantry (Recipes & Drinks)

Default path:

```bash
~/.config/grillz/recipes/
~/.config/grillz/drinks/
```

Structure:

```bash
recipes/               # one .md per tool or snippets collection
```

Starter examples live in examples/recipes/ and examples/drinks -- copy them:
```bash
mkdir -p ~/.config/grillz/recipes/
mkdir -p ~/.config/grillz/drinks/
cp -r examples/recipes/* ~/.config/grillz/recipes/
cp -r examples/drinks/* ~/.config/grillz/drinks/
```

---

## 🚀 Usage

```bash
grillz                 # banner → quick menu → fzf → fill vars 
grillz -p              # print final command only
grillz -q              # minimal prompts (no banner, terse inputs)

# Recipes mode
grillz recipes         # open directly in recipes
grillz -R              # shorthand for recipes

# Drinks mode
grillz drinks          # open directly in drinks
grillz -D              # shorthand for drinks

# Admin
grillz new "Desc" 'cmd <var>'
grillz list
grillz edit [file]
grillz install
grillz doctor
```

---

## 🧪 Recipe Format

Two lines per entry in `.md`:

```
# [Phase] Description --tool
command <var1> <var2>
```

Example:
```
# [Exploitation] MySQL dump with sqlmap --sqlmap
sqlmap -u "<url>" -D <database> -T <table> --dump --batch
```

---

## ⚠️ Disclaimer

**Grillz is for legal penetration testing and educational purposes only.**  
Use it **only** on systems you own or have explicit permission to test.  
The authors take **no responsibility** for misuse or damage.  
You are fully responsible for your actions.

---

## 🛠 Development

Clone repo:
```bash
git clone https://github.com/wabynox/grillz.git ~/src/grillz
cd ~/src/grillz
```

Symlink for live dev:
```bash
PREFIX="$HOME/.local" ./bin/grillz link
grillz doctor
```

Run lint before PR:
```bash
shellcheck -x bin/grillz lib/grillz/*.sh lib/grillz/cmds/*.sh
```

---

## 🤝 Contribute

Contributions welcome! Please check [CONTRIBUTING.md](CONTRIBUTING.md).  
- Keep Bash POSIX-friendly (`set -euo pipefail`).  
- No deps beyond coreutils + `fzf`.  
- Add/update recipes in strict format.  
- Add tests/examples when relevant.

---

## 📜 License

[MIT](LICENSE)

---

## 🔥 Status

🚧 Grillz is under active development.  
Expect frequent changes while recipes and modules grow.
