# website

Static site for [GalliaBelgicaSystems](https://galliabelgica.systems/).
Markdown in `content/` compiles to static HTML in `public/` via pandoc.

## Edit

- Page text: `content/index.md`
- HTML shell + styling: `templates/base.html`
- Logo: `assets/gallia-belgica.svg` (copied to `public/gallia-belgica.svg` on build)
- Custom domain: `CNAME` (copied to `public/CNAME` on build)

## Build

```bash
nix develop
make build   # -> public/index.html + public/CNAME + public/gallia-belgica.svg
make serve   # serve public/ on http://localhost:8000
make clean
```

Requires the Nix dev shell (pinned to `nixos-26.05`, provides pandoc,
gnumake, python3, git). CI installs pandoc via apt and runs `make build`.

## Hosting

GitHub Pages (`.github/workflows/pages.yml`) deploys `public/` on every
push to `master`/`main`. Custom domain `galliabelgica.systems` is set via
the `CNAME` file; see "Custom domain / Namecheap" below.

## Custom domain / Namecheap

Repo side is done (`CNAME` containing `galliabelgica.systems`, deployed as
`public/CNAME`). Two manual steps remain:

1. **GitHub:** repo Settings → Pages → Custom domain → enter
   `galliabelgica.systems`, Save. Wait for the TLS certificate
   ("Certificate active"), then tick Enforce HTTPS.
2. **Namecheap:** Domain List → Manage → Advanced DNS, with these records
   (replace `GalliaBelgicaSystems` with the actual GitHub org/user name if
   different):

   | Type  | Host | Value                                | TTL      |
   |-------|------|--------------------------------------|----------|
   | A     | @    | 185.199.108.153                      | Automatic|
   | A     | @    | 185.199.109.153                      | Automatic|
   | A     | @    | 185.199.110.153                      | Automatic|
   | A     | @    | 185.199.111.153                      | Automatic|
   | CNAME | www  | GalliaBelgicaSystems.github.io.      | Automatic|

   Notes:
   - The apex (`@`) needs the four GitHub Pages A records; a CNAME on the
     apex is not valid DNS, so keep `@` on A records and put the CNAME on
     `www` only.
   - `www` target must be the org/user pages host
     (`<org>.github.io.` with trailing dot in Namecheap), not this repo's
     project path — GitHub routes by the `CNAME` file content.
   - Remove any conflicting URL Redirect / parking records for `@`/`www`.
   - DNS + GitHub's certificate check can take minutes to hours. Verify
     with `dig galliabelgica.systems +short` (expect the four A IPs) and
     `dig www.galliabelgica.systems +short` (expect the pages host).
