<script>
  import MediaCarousel from "~/shared/MediaCarousel.svelte";
  import ProfileDetails from "~/shared/ProfileDetails.svelte";
  import TaggedNews from "~/shared/TaggedNews.svelte";
  import { profileAsset } from "~/profiles.js";

  let { profile, news, locale } = $props();

  const media = $derived((profile.media || []).map((item) => ({
    ...item,
    ...(item.asset ? { src: profileAsset("artists", item.asset) } : {})
  })));
  const mediaLabel = $derived(locale === "ja" ? "Stefanの写真と動画" : "Photos and videos of Stefan");
  const fullscreenLabel = $derived(locale === "ja" ? "全画面表示" : "Fullscreen");
  const closeLabel = $derived(locale === "ja" ? "閉じる" : "Close");
  const ofLabel = $derived(locale === "ja" ? "/" : "of");
</script>

{#if media.length}
  <MediaCarousel
    items={media}
    label={mediaLabel}
    {fullscreenLabel}
    {closeLabel}
    {ofLabel}
    {locale}
  />
{/if}
<ProfileDetails {profile} {locale} profileType="artists" slug={profile.slug} />
<TaggedNews {news} {locale} entityType="artist" />
