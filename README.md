# webstir-demos

> This repository is legacy and no longer the source of truth.
> Active development has moved to the canonical Webstir monorepo:
> [webstir-io/webstir](https://github.com/webstir-io/webstir)
>
> Demo source location in the monorepo:
> `examples/demos`

Helper scripts:
- `utils/watch-demo.sh <ssg|spa|api|full> [base|site] [<webstir-watch-args...>]` — start watch without re-initializing.
- `utils/enable-feature.sh <project|ssg|ssg-base|ssg-site|spa|api|full> <feature> [<feature-args...>]` — enable a feature in a demo or any project folder.

Demo folders:
- `api/` — backend-only
- `full/` — fullstack (frontend + backend)
- `spa/` — SPA frontend
- `ssg/base/` — SSG starter (no optional features enabled)
- `ssg/site/` — SSG starter (features enabled; see `utils/refresh-ssg.sh site`)

Convenience scripts:
- `utils/refresh-ssg.sh <base|site>` / `utils/watch-ssg.sh <base|site>`
- `utils/refresh-spa.sh` / `utils/watch-spa.sh`
- `utils/refresh-api.sh` / `utils/watch-api.sh`
- `utils/refresh-full.sh` / `utils/watch-full.sh`
- `utils/serve-demo.sh <ssg|spa|api|full> [base|site] [--host <host>] [--port <port>]`
- `utils/serve-ssg.sh <base|site>`
