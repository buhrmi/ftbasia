# Follow The Bass

Follow The Bass is a bilingual (Japanese and English) Rails application with
Svelte pages powered by Inertia. Content is stored in SQLite and managed through
Active Record; uploaded media uses Active Storage.

## Requirements

- Ruby 4.0+
- Node.js 20+
- SQLite 3

## Development

Install the Ruby and JavaScript dependencies, prepare the database, and start
Rails and Vite together:

```sh
bundle install
npm install
bin/rails db:prepare
bin/rails db:seed
bin/dev
```

The site is available at `http://localhost:3000`. Japanese is the default
locale, and English pages use the `/en` prefix.

## Content and media

Run `bin/rails db:seed` to import the initial content from
[`db/seeds/content.json`](db/seeds/content.json) and its referenced files in
`db/seeds/assets/`. The seed task is safe to rerun. Future content should be
created through Active Record or an editorial interface rather than editing
the original SvelteKit YAML and Markdown files.

Images, flyers, and videos are attached with Active Storage. Local development
stores files under `storage/`; deploy with a persistent disk or configure a
remote Active Storage service for production. Localized `alt_text` and
`caption`, along with credit and ordering metadata, are stored on the
`active_storage_attachments` records.

## Checks

```sh
npm test
npm run build
```

`npm test` runs the Rails test suite. Before deploying, run migrations with
`bin/rails db:migrate` and ensure the production database and Active Storage
files use persistent storage.
