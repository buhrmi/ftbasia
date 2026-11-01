const locales = new Set(["en", "ja"]);

export function parseLocale(value) {
  return locales.has(value) ? value : undefined;
}
