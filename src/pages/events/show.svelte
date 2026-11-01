<script>
  import EventDetails from "~/shared/EventDetails.svelte";
  import ProfileDetails from "~/shared/ProfileDetails.svelte";
  import TaggedNews from "~/shared/TaggedNews.svelte";

  let { profile, news, locale } = $props();
</script>

<ProfileDetails {profile} {locale} profileType="events" slug={profile.slug} />
<EventDetails {profile} {locale} />
<TaggedNews {news} {locale} entityType="event" />
