import { existsSync, readdirSync, readFileSync } from "node:fs";
import { join, resolve } from "node:path";
import { parse } from "yaml";

const CONTENT_DIR = resolve(process.cwd(), "src/content");
const DEFAULT_LOCALE = "ja";
const LOCALES = new Set(["en", "ja"]);
const SLUG_PATTERN = /^[a-z0-9]+(?:-[a-z0-9]+)*$/;
const FRONT_MATTER = /^---\s*\n([\s\S]*?)\n---\s*\n/;
const PROFILE_TYPES = {
  artist: "artists",
  event: "events"
};

function isRecord(value) {
  return value !== null && typeof value === "object" && !Array.isArray(value);
}

function readYaml(path, label) {
  const data = parse(readFileSync(path, "utf8"));
  if (!isRecord(data)) throw new Error(`Invalid YAML content: ${label}`);
  return data;
}

function filesIn(directory, extension) {
  const path = join(CONTENT_DIR, directory);
  return readdirSync(path, { withFileTypes: true })
    .filter((entry) => entry.isFile() && entry.name.endsWith(extension))
    .map((entry) => entry.name)
    .sort();
}

function localizedText(value, locale) {
  if (typeof value === "string") return value.trim() ? value : undefined;
  if (!isRecord(value)) return value == null ? undefined : String(value);

  const result =
    value[locale] ||
    value[DEFAULT_LOCALE] ||
    Object.values(value).find((text) => text != null && String(text).trim());
  return result == null || !String(result).trim() ? undefined : String(result);
}

function localizedEntries(value, locale) {
  if (!isRecord(value)) return value == null ? [] : value;
  return value[locale] ?? value[DEFAULT_LOCALE] ?? Object.values(value)[0] ?? [];
}

function entries(value) {
  if (value == null) return [];
  return Array.isArray(value) ? value : [value];
}

function profileLinks(data, key, slug) {
  return entries(data[key]).map((entry) => {
    if (!isRecord(entry)) throw new Error(`Invalid ${key} entry in profile ${slug}`);
    const label = String(entry.label ?? "");
    const url = String(entry.url ?? "");
    if (!label.trim() || !url.trim()) throw new Error(`Invalid ${key} entry in profile ${slug}`);
    return { label, url };
  });
}

function profileInterview(value, locale, slug) {
  const selected = localizedEntries(value, locale);
  if (selected == null) return [];
  if (!Array.isArray(selected)) {
    throw new Error(`Profile interview entries must be a list: ${slug}`);
  }

  return selected.map((entry) => {
    if (!isRecord(entry) || !entry.question || !entry.answer) {
      throw new Error(`Invalid interview entry in profile ${slug}`);
    }

    const result = {
      question: String(entry.question),
      answer: String(entry.answer)
    };

    if (entry.link != null) {
      if (!isRecord(entry.link) || !entry.link.label || !entry.link.url) {
        throw new Error(`Invalid interview link in profile ${slug}`);
      }
      result.link = { label: String(entry.link.label), url: String(entry.link.url) };
    }
    return result;
  });
}

function profileMedia(value, locale, slug) {
  if (!Array.isArray(value)) throw new Error(`Profile media must be a list: ${slug}`);
  return value.map((item) => {
    if (!isRecord(item)) throw new Error(`Invalid media entry in profile ${slug}`);
    const kind = String(item.kind ?? "");
    if (!["tiktok", "video", "image"].includes(kind)) {
      throw new Error(`Invalid media kind in profile ${slug}`);
    }

    const alt = localizedText(item.alt, locale);
    if (!alt) throw new Error(`Media alt text cannot be blank in profile ${slug}`);
    const result = { kind, alt };
    const caption = localizedText(item.caption, locale);
    if (caption) result.caption = caption;

    if (kind === "tiktok") {
      result.video_id = String(item.video_id ?? "");
      if (!result.video_id) throw new Error(`Invalid TikTok video ID in profile ${slug}`);
    } else {
      result.asset = String(item.asset ?? "");
      if (!result.asset) throw new Error(`Invalid media asset in profile ${slug}`);
    }

    if (kind === "image") {
      result.width = Number(item.width);
      result.height = Number(item.height);
      if (!Number.isInteger(result.width) || !Number.isInteger(result.height)) {
        throw new Error(`Invalid image dimensions in profile ${slug}`);
      }
    }
    return result;
  });
}

function localizedList(value, locale) {
  const selected = localizedEntries(value ?? {}, locale);
  return entries(selected).map(String);
}

function localizedWork(value, locale, slug) {
  const selected = localizedEntries(value ?? {}, locale);
  return entries(selected).map((item) => {
    if (!isRecord(item)) throw new Error(`Invalid work entry in event ${slug}`);
    const title = String(item.title ?? "");
    const body = String(item.body ?? "");
    if (!title.trim() || !body.trim()) throw new Error(`Invalid work entry in event ${slug}`);
    return { title, body };
  });
}

function eventStartsAt(value, slug) {
  if (value == null) return undefined;
  const startsAt = String(value);
  if (!startsAt || Number.isNaN(Date.parse(startsAt))) {
    throw new Error(`Invalid event start time: ${slug}`);
  }
  return startsAt;
}

function profileData(type, slug) {
  const directory = PROFILE_TYPES[type];
  if (!directory || !SLUG_PATTERN.test(String(slug))) return;
  const path = join(CONTENT_DIR, directory, `${slug}.yml`);
  if (!existsSync(path)) return;
  return { type, slug, data: readYaml(path, `${directory}/${slug}.yml`) };
}

export function getProfile(type, slug, locale) {
  if (!LOCALES.has(locale)) throw new Error(`Unsupported locale: ${locale}`);
  const record = profileData(type, slug);
  if (!record) return;

  const { data } = record;
  const name = String(data.name ?? "");
  if (!name.trim()) throw new Error(`Profile name cannot be blank: ${slug}`);
  const textFields = ["role", "location", "tagline"];
  for (const key of textFields) {
    if (
      data[key] != null &&
      typeof data[key] !== "string" &&
      !isRecord(data[key])
    ) {
      throw new Error(`Profile text must be a string or localized text: ${slug}`);
    }
  }
  if (!isRecord(data.bio ?? {})) throw new Error(`Profile bio must be localized text: ${slug}`);
  if (!isRecord(data.interview ?? {})) {
    throw new Error(`Profile interview must be localized entries: ${slug}`);
  }

  const profile = {
    slug,
    name,
    role: localizedText(data.role, locale),
    location: localizedText(data.location, locale),
    tagline: localizedText(data.tagline, locale),
    bio: localizedText(data.bio, locale),
    links: profileLinks(data, "links", slug),
    sources: profileLinks(data, "sources", slug),
    interview: profileInterview(data.interview ?? {}, locale, slug),
    media: profileMedia(data.media ?? [], locale, slug)
  };
  if (type === "event") {
    profile.kind = localizedText(data.kind, locale);
    profile.starts_at = eventStartsAt(data.starts_at, slug);
    profile.description = localizedText(data.description, locale);
    profile.performers = localizedList(data.performers, locale);
    profile.work = localizedWork(data.work, locale, slug);
    profile.flyer = data.flyer == null ? undefined : String(data.flyer);
  }

  return profile;
}

function parseFrontMatter(path) {
  const contents = readFileSync(path, "utf8");
  const match = FRONT_MATTER.exec(contents);
  if (!match) return {};
  const data = parse(match[1]) ?? {};
  if (!isRecord(data)) throw new Error(`Invalid news front matter: ${path}`);
  return data;
}

function newsFiles() {
  const directory = join(CONTENT_DIR, "news");
  return readdirSync(directory, { withFileTypes: true })
    .filter((entry) => entry.isDirectory())
    .flatMap((entry) =>
      readdirSync(join(directory, entry.name), { withFileTypes: true })
        .filter((file) => file.isFile() && file.name.endsWith(".md"))
        .map((file) => join(directory, entry.name, file.name))
    )
    .sort();
}

function newsRecord(path) {
  const slug = path.split("/").at(-2);
  const locale = path.split("/").at(-1).replace(/\.md$/, "");
  const data = parseFrontMatter(path);
  const publishedAt = data.published_at ?? data.created_at;
  return {
    slug,
    locale,
    title: String(data.title ?? ""),
    description: String(data.description ?? ""),
    category: data.category == null ? undefined : String(data.category),
    published_at: publishedAt == null ? undefined : String(publishedAt),
    tagData: data.tags
  };
}

function newsTags(article, locale) {
  return entries(article.tagData).map((tag) => {
    if (!isRecord(tag)) throw new Error(`Invalid news tag in ${article.slug}`);
    const type = String(tag.type ?? "");
    const slug = String(tag.slug ?? "");
    if (!PROFILE_TYPES[type]) throw new Error(`Unknown news tag type: ${type}`);
    const profile = getProfile(type, slug, locale);
    if (!profile) throw new Error(`Unknown ${type} tag: ${slug}`);
    return {
      type,
      slug: profile.slug,
      name: profile.name,
      url: localizedPath(locale, `/${PROFILE_TYPES[type]}/${slug}`)
    };
  });
}

function newsProps(article, locale) {
  return {
    slug: article.slug,
    locale: article.locale,
    title: article.title,
    description: article.description,
    category: article.category,
    published_at: article.published_at,
    url: localizedPath(article.locale, `/news/${article.slug}`),
    tags: newsTags(article, locale)
  };
}

function publishedTime(article) {
  if (!article.published_at) return 0;
  const time = Date.parse(article.published_at);
  return Number.isNaN(time) ? 0 : time;
}

export function getNewsForIndex(locale) {
  if (!LOCALES.has(locale)) throw new Error(`Unsupported locale: ${locale}`);
  const bySlug = new Map();
  for (const path of newsFiles()) {
    const article = newsRecord(path);
    const translations = bySlug.get(article.slug) ?? [];
    translations.push(article);
    bySlug.set(article.slug, translations);
  }

  return [...bySlug.values()]
    .map((translations) =>
      translations.find((article) => article.locale === locale) ?? translations[0]
    )
    .sort((a, b) => publishedTime(b) - publishedTime(a))
    .map((article) => newsProps(article, locale));
}

export function getNews(locale, slug) {
  if (!LOCALES.has(locale) || !SLUG_PATTERN.test(String(slug))) return;
  const path = join(CONTENT_DIR, "news", slug, `${locale}.md`);
  if (!existsSync(path)) return;
  return newsProps(newsRecord(path), locale);
}

export function getTaggedNews(type, slug, locale) {
  return getNewsForIndex(locale).filter((article) =>
    article.tags.some((tag) => tag.type === type && tag.slug === slug)
  );
}

export function localizedPath(locale, path) {
  return locale === "en" ? `/en${path}` : path;
}

export function pageMeta({ title, description, type = "website", publishedAt, locale, url }) {
  return {
    title,
    description: description || undefined,
    canonical_url: url.href,
    origin: url.origin,
    og_type: type,
    og_locale: locale === "en" ? "en_US" : "ja_JP",
    published_at: publishedAt
  };
}

export function localizedNewsIndexMeta(locale) {
  return locale === "en"
    ? {
        title: "News — Follow The Bass",
        description: "Interviews, announcements and stories from Follow The Bass."
      }
    : {
        title: "ニュース — Follow The Bass",
        description: "Follow The Bassのインタビュー、お知らせ、ストーリー。"
      };
}
