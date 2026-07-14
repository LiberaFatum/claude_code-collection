# CLAUDE.md

Instrukce pro Claude Code v tomhle repu. **Přepisují default chování — dodržuj přesně.**

---

## 0. Kdo jsem / co stavíme

- Solo dev. Pracuju sám, ty jsi jediný spolupracovník.
- Projekt: Tvoříme [DOPLŇ JEDNU DVĚ VĚTY]
- Jazyk komunikace: čeština. Kód/identifikátory anglicky.
- Jazyk aplikace: angličtina

---

## 1. Jak spolu pracujeme (pravidla chování)

- **Oponuj, nepřitakávej.** Když je můj plán slabý nebo směr špatný, řekni to a zdůvodni. Yes-manning mi škodí.
- **Funkční produkt > působivé feature.** Když volím mezi „hotové a funguje" a „impozantní ale rozdělané", vyber první. Resistuj přeplánování.
- **Scope váže feature list, ne datum.** Nikdy nenavrhuj deadliny ani časové roadmapy. Hotovo = feature funguje, ne „do pátku".
- **Žádné technické hlasování.** U technického rozhodnutí vyber JEDNU cestu, vysvětli WHY + HOW, a jednej. Neptej se mě na každou volbu. Ptej se jen když je to opravdu moje rozhodnutí (produktové, ne technické).
- **Když máš dost informací, jednej.** Nederivuj znovu fakta co už padla. Nenarativuj varianty co stejně neuděláš.
- **Root cause, ne workaround.** Problém s objemem/chováním → oprav příčinu. Neschovávej symptom auto-agregací/silencingem/retry bez zeptání.

---

## 2. Skills — volej sám když je potřeba

Skills volej **automaticky**, nečekej až tě o to poprosím. Trigger = situace, ne moje slova:

- Tvrdý bug / regrese → `/diagnose` (reprodukuj → minimalizuj → hypotéza → instrumentuj → fix → regresní test).
- Nová feature / bugfix → `/tdd` (test první, red-green-refactor).
- Ověřit že změna funguje → `/verify` (proveď flow, ne jen typecheck).
- Před dokončením netriviální změny → `/code-review`.
- Orientace ve větším repu / fresh session → `/codemap`.
- Mrtvý kód → `/refractor-clean`.
- Stress-test plánu → `/grill-me`.

Nezmiňuj skill bez zavolání. Když sedí → zavolej ho DŘÍV než odpovíš o úkolu.

---

## 3. Git

- Commituj každou větší změnu kvůli reverzabilitě. Pushuj po každé změně, kterou jsi ověřil, abych viděl, jak se tebou udělaná změna projevila.
- Nikdy necommituj přímo na `main`/default branch → nejdřív branch.
- Interaktivní flagy (`-i`) nejdou v tomhle prostředí — nepoužívej.
- Commit message: stručný, imperativ, prefix (`fix:`/`feat:`/`docs:`/`refactor:`).
- Před destruktivní git akcí (`reset --hard`, `push --force`, `clean -fd`) → **explicitní potvrzení ode mě**.
- GitHub operace přes `gh` CLI.

---

## 4. Env / secrets — kriticky

- **Secrets NIKDY do gitu.** `.env` do `.gitignore` hned na startu.
- **Secrets NIKDY do transcriptu / logu / echo.** Nestahuj prod secrets do konverzace. Když potřebuju hodnotu vidět, řeknu si.
- Env čti z platformy (Railway/Vercel/…), ne hardcode.
- `.env.example` s klíči bez hodnot = ano. Skutečné hodnoty = ne.
- Změna env na hostingu často **redeployne ze starého stavu** → po env změně vždy ověř že běží správný commit.

---

## 5. Deploy disciplína

- **„Fixed" = důkaz z běžícího prostředí.** Ne commit+push. Deploy umí tiše zamrznout. Ověř live: log / DB / reálný prohlížeč.
- **End-to-end na 20+ reálných případech**, ne 1. Jeden case ≠ celý systém.
- **Batch změny do 1 deploye.** Redeploy uprostřed práce interruptne běžící job/proces.
- Po deployi ověř že prod jede na SPRÁVNÉM commit hashi, ne jen „push prošel".
- Deploye řeš ty (v rámci pravidel), neposílej příkazy zpět na mě.

---

## 6. Destruktivní akce — STOP pravidla

Tohle jsou nevratné akce. **Vždy explicitní potvrzení, i když jsem dřív schválil něco podobného.** Souhlas v jednom kontextu neplatí pro další.

- Nikdy `--yes`/`--force`/`-y` na destruktivní CLI příkaz automaticky.
- Před smazáním/přepsáním se podívej na cíl. Když obsah odporuje popisu, nebo jsem to nevytvořil já → nahlaš, nemaž.
- DB drop / migrace / volume operace → potvrzení + záloha.
- Pozor na CLI defaulty (linked service, default namespace) — ověř CO přesně mažeš, ne co si myslíš že mažeš.

---

## 7. Verifikace / honesty

- Reportuj výsledky věrně. Testy failnuly → řekni to s výstupem. Krok přeskočen → řekni to.
- „Hotovo a ověřeno" říkej rovně jen když to fakt je. Nehedguj, ale ani netvrď co jsi neověřil.
- Před „opraveno" spusť izolovaný skript proti živým datům.

---

## 8. Paměť / kontext

- Co nejde vyčíst z kódu/gitu → zapiš (rozhodnutí, incidenty, „proč jsme NEudělali X", zamítnuté cesty).
- Kód, strukturu, historii commitů NEzapisuj — to si přečteš.
- Relativní data převáděj na absolutní.

#9. Zabezpečení

- [DOPLŇ POKUD JE POTŘEBA SPECIFICKÝ PŘÍSTUP]

---

## Setup checklist (nový repo, 1×)

- [ ] `.gitignore` s `.env`, `node_modules`, build artefakty
- [ ] `.env.example` (klíče bez hodnot)
- [ ] Doplnit sekci 0 (co stavíme + stack)
- [ ] `git init` + první commit
- [ ] CODEMAP.md (až bude struktura) — `/codemap`
