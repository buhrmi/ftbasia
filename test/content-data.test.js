import { readdirSync } from "node:fs";
import { join } from "node:path";
import { describe, expect, test } from "bun:test";
import { fileURLToPath } from "node:url";
import {
  getNews,
  getNewsForIndex,
  getProfile,
  getTaggedNews
} from "../src/contentData.server.js";
import { parseLocale } from "../src/params/locale.js";

const contentDirectory = fileURLToPath(new URL("../src/content/", import.meta.url));

describe("file-backed content", () => {
  test("accepts only supported explicit locales", () => {
    expect(parseLocale("en")).toBe("en");
    expect(parseLocale("ja")).toBe("ja");
    expect(parseLocale("fr")).toBeUndefined();
  });

  test("loads news in both locales with category, links, and artist tags", () => {
    const english = getNewsForIndex("en");
    const japanese = getNewsForIndex("ja");
    expect(english).toHaveLength(3);
    expect(japanese).toHaveLength(3);
    expect(english.map((article) => article.category)).toEqual([
      "release",
      "interview",
      "release"
    ]);

    const interview = getNews("en", "stefan-opens-up-after-8-years-in-tokyo");
    expect(interview?.tags.map(({ type, slug }) => ({ type, slug }))).toEqual([
      { type: "artist", slug: "stefan" }
    ]);
    expect(interview?.url).toBe("/en/news/stefan-opens-up-after-8-years-in-tokyo");
  });

  test("localizes artist profiles and media", () => {
    const stefan = getProfile("artist", "stefan", "ja");
    expect(stefan?.role).toBe("アーティスト・創設者");
    expect(stefan?.interview).toHaveLength(6);
    expect(stefan?.media.map(({ kind }) => kind)).toEqual(["tiktok", "video", "image"]);
    expect(getProfile("artist", "allen-mock", "en")?.links[0].url).toBe(
      "https://allenmock.bandcamp.com/"
    );
  });

  test("includes event details and tagged news on the event profile", () => {
    const event = getProfile("event", "tokyo-bass-conference", "ja");
    expect(event?.name).toBe("Tokyo Bass Conference feat. Far Too Loud");
    expect(event?.starts_at).toBe("2016-01-23T22:00:00+09:00");
    expect(event?.performers).toEqual(["Far Too Loud"]);
    expect(event?.work[0].title).toBe("ブッキング");
    expect(event?.flyer).toBe("2016-far-too-loud.jpg");
    expect(event?.links[0].url).toBe("https://www.facebook.com/TokyoBassMusic/");
    expect(getTaggedNews("artist", "stefan", "en")).toHaveLength(1);
    expect(getProfile("event", "tokyo-bass-conference", "en")?.description).toContain(
      "booking process"
    );
  });

  test("loads every profile in both locales", () => {
    for (const [type, directory] of [
      ["artist", "artists"],
      ["event", "events"]
    ]) {
      for (const filename of readdirSync(join(contentDirectory, directory))) {
        if (!filename.endsWith(".yml")) continue;
        const slug = filename.replace(/\.yml$/, "");
        expect(getProfile(type, slug, "ja")).toBeDefined();
        expect(getProfile(type, slug, "en")).toBeDefined();
      }
    }
  });

  test("returns no record for invalid or missing slugs", () => {
    expect(getNews("en", "../secret")).toBeUndefined();
    expect(getProfile("artist", "missing-artist", "en")).toBeUndefined();
    expect(getProfile("event", "missing-event", "ja")).toBeUndefined();
  });
});
