import { existsSync, readFileSync, readdirSync } from "node:fs";
import { join } from "node:path";
import { describe, expect, test } from "bun:test";
import { fileURLToPath } from "node:url";
import {
  getNews,
  getNewsForIndex,
  getArtistIndex,
  getPastEvents,
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
    expect(english).toHaveLength(5);
    expect(japanese).toHaveLength(5);
    expect(english.map((article) => article.category)).toEqual([
      "event",
      "announcement",
      "release",
      "interview",
      "release"
    ]);
    expect(english[0].slug).toBe("06s-25th-anniversary-at-womb");

    const interview = getNews("en", "stefan-opens-up-after-8-years-in-tokyo");
    expect(interview?.tags.map(({ type, slug }) => ({ type, slug }))).toEqual([
      { type: "artist", slug: "danangbassman" }
    ]);
    expect(interview?.url).toBe("/en/news/stefan-opens-up-after-8-years-in-tokyo");
  });

  test("includes the 06S anniversary flyer, lineup, and ticket link", () => {
    const slug = "06s-25th-anniversary-at-womb";
    const english = getNews("en", slug);
    const japanese = getNews("ja", slug);
    const englishContent = readFileSync(join(contentDirectory, `news/${slug}/en.md`), "utf8");
    const japaneseContent = readFileSync(join(contentDirectory, `news/${slug}/ja.md`), "utf8");

    expect(english?.category).toBe("event");
    expect(english?.published_at).toBe("2026-11-05");
    expect(english?.tags.map(({ slug: artistSlug }) => artistSlug)).toEqual(["dj-aki", "yellock"]);
    expect(japanese?.category).toBe("event");
    expect(englishContent).toContain("Friday, November 6, 2026");
    expect(englishContent).toContain("https://womb.zaiko.io/en/e/womb110626");
    expect(englishContent).toContain("Friction");
    expect(englishContent).toContain("DJ AKi");
    expect(japaneseContent).toContain("2026年11月6日（金）");
    expect(japaneseContent).toContain("https://womb.zaiko.io/en/e/womb110626");
    expect(existsSync(join(contentDirectory, `news/${slug}/og.png`))).toBe(true);
  });

  test("localizes artist profiles and media", () => {
    const stefan = getProfile("artist", "danangbassman", "ja");
    expect(stefan?.role).toBe("アーティスト・創設者");
    expect(stefan?.bio).toContain("ウェブ開発者");
    expect(stefan?.links.some(({ url }) => url === "https://github.com/buhrmi")).toBe(true);
    expect(stefan?.interview).toEqual([]);
    expect(stefan?.media.map(({ kind }) => kind)).toEqual(["tiktok", "video", "image"]);
    expect(getProfile("artist", "danangbassman", "en")?.bio).toContain("former web developer");
    expect(getProfile("artist", "stefan", "en")).toBeUndefined();
    expect(getProfile("artist", "allen-mock", "en")?.links[0].url).toBe(
      "https://allenmock.bandcamp.com/"
    );
  });

  test("lists artists with localized profile URLs", () => {
    const english = getArtistIndex("en");
    const japanese = getArtistIndex("ja");
    expect(english).toHaveLength(5);
    expect(english.map(({ slug }) => slug)).toContain("danangbassman");
    expect(english.find(({ slug }) => slug === "danangbassman")?.url).toBe(
      "/en/artists/danangbassman"
    );
    expect(japanese.find(({ slug }) => slug === "danangbassman")?.url).toBe(
      "/artists/danangbassman"
    );
  });

  test("keeps Stefan's expanded interview details in the news article", () => {
    const english = readFileSync(
      join(contentDirectory, "news/stefan-opens-up-after-8-years-in-tokyo/en.md"),
      "utf8"
    );
    const japanese = readFileSync(
      join(contentDirectory, "news/stefan-opens-up-after-8-years-in-tokyo/ja.md"),
      "utf8"
    );
    expect(english).toContain("New Sound For Japan");
    expect(english).toContain("Tokyo Bass Music");
    expect(english).toContain("live on Twitch");
    expect(japanese).toContain("New Sound For Japan");
    expect(japanese).toContain("Tokyo Bass Music");
    expect(japanese).toContain("Twitchでライブ配信");
  });

  test("includes event details and tagged news on the event profile", () => {
    const event = getProfile("event", "tokyo-bass-conference", "ja");
    expect(event?.name).toBe("Tokyo Bass Conference feat. Far Too Loud");
    expect(event?.starts_at).toBe("2016-01-23T22:00:00+09:00");
    expect(event?.performers).toEqual(["Far Too Loud"]);
    expect(event?.work[0].title).toBe("ブッキング");
    expect(event?.flyer).toBe("2016-far-too-loud.jpg");
    expect(event?.links[0].url).toBe("https://www.facebook.com/TokyoBassMusic/");
    expect(getTaggedNews("artist", "danangbassman", "en")).toHaveLength(1);
    expect(getProfile("event", "tokyo-bass-conference", "en")?.description).toContain(
      "booking process"
    );
  });

  test("lists past events with localized event links", () => {
    const english = getPastEvents("en");
    const japanese = getPastEvents("ja");
    expect(english).toHaveLength(1);
    expect(english[0].flyer).toBe("2016-far-too-loud.jpg");
    expect(english[0].url).toBe("/en/events/tokyo-bass-conference");
    expect(japanese[0].url).toBe("/events/tokyo-bass-conference");
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
