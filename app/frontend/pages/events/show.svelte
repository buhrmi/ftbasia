<script>
  import ProfileDetails from "~/shared/ProfileDetails.svelte";
  import TaggedNews from "~/shared/TaggedNews.svelte";

  let { profile, news, locale } = $props();
</script>

<ProfileDetails {profile} {locale} profileType="events" slug={profile.slug} />
<TaggedNews {news} {locale} entityType="event" />
