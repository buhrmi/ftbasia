# Follow The Bass

The site is a SvelteKit application deployed to Netlify. Artist and event
details are read from YAML files; news articles are Markdown files with YAML
front matter. No database or Rails runtime is required.

## Development

Install [Bun](https://bun.sh/), then run:

```sh
bun install
bun run dev
```

The development server is available at `http://localhost:5173`. Japanese is the
default locale (`/news`); English pages use `/en` (`/en/news`).

## Verification and deployment

```sh
bun test
bun run build
```

Netlify uses the SvelteKit Netlify adapter and the settings in `netlify.toml`.
Connect the repository to Netlify and it will install dependencies, run the
build, and publish the generated site and serverless function. The content files
are included with the function so YAML-backed routes work at runtime.

## Content

- `src/content/artists/*.yml`
- `src/content/events/*.yml`
- `src/content/news/<slug>/<locale>.md`

Markdown news files may include a preview image in their article directory.
