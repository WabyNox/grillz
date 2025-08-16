# Contributing to Grillz 🔥

Thanks for your interest in contributing to **Grillz**!
This project is still young and evolving fast, so contributions are very welcome.

Please follow the guidelines below to keep things consistent and easy to maintain.

---

## 📋 Code Guidelines

* Use **Bash** (POSIX-friendly).

  * Always start scripts with:

    ```bash
    #!/usr/bin/env bash
    set -euo pipefail
    ```
* Keep dependencies minimal:

  * Only `coreutils` and `fzf` are required.
  * Do not introduce heavy external tools.
* Organize code in `lib/grillz/` and `lib/grillz/cmds/`.

  * Core functions go in `core.sh`.
  * User-facing commands go in `cmds/*.sh`.
* Run **shellcheck** before opening a pull request:

  ```bash
  shellcheck -x bin/grillz lib/grillz/*.sh lib/grillz/cmds/*.sh
  ```

---

## 🗂 Recipes & Drinks Guidelines

Recipes and drinks are the heart of Grillz. Please keep them **strict and consistent**.

### Format

Each recipe is **two lines**:

```md
# [Phase] Description --tool
command <var1> <var2>
```

Examples:

```md
# [Recon] Subdomain brute-force --ffuf
ffuf -u http://FUZZ.<domain>/ -w <wordlist>

# [Exploitation] MySQL dump with sqlmap --sqlmap
sqlmap -u "<url>" -D <database> -T <table> --dump --batch
```

* **Phase** must be one of:
  `Recon`, `Enumeration`, `Exploitation`, `Post-Exploitation`, `Covering`.
* **Tool** goes after `--` at the end of the description.
* **Variables** must be written as `<var>`, not `$var` or `%var%`.
* Use lowercase for tool names (e.g. `--nmap`, not `--Nmap`).
* Keep descriptions concise and action-oriented.

### File organization

* One `.md` file per tool under:

  ```
  ~/.config/grillz/recipes/tools/
  ~/.config/grillz/drinks/
  ```
* Shared snippets (e.g., reverse shells, wordlists, common payloads) go in:

  ```
  ~/.config/grillz/recipes/shared/
  ```

---

## 🚀 Workflow

1. Fork the repository and create a feature branch:

   ```bash
   git checkout -b feature/my-change
   ```
2. Add or edit code/recipes following the guidelines.
3. Run `shellcheck` and `grillz doctor` locally.
4. Commit using clear messages:

   ```
   feat: add ffuf.md recipes
   fix: correct typo in nmap command
   docs: update README with drinks mode
   ```
5. Push to your fork and open a pull request.

---

## 📖 Documentation

* Update `README.md` if you add new features.
* Document new recipes with comments if needed.
* Keep formatting clean and consistent.

---

## 🤝 Communication

* Use GitHub Issues for bugs and feature requests.
* Be constructive and respectful: Grillz is built for the community.
* Share new cheatsheets or payloads if you think they’re useful!

---

## ⚠ Disclaimer Reminder

All contributions must comply with Grillz’s disclaimer:
**For legal penetration testing and educational purposes only.**
