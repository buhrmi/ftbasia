<script>
  import ProfileDetails from "~/shared/ProfileDetails.svelte";
  import Shows from "~/shared/Shows.svelte";
  import TaggedNews from "~/shared/TaggedNews.svelte";

  let { profile, news, shows = [], locale } = $props();
</script>

<ProfileDetails {profile} {locale} profileType="events" slug={profile.slug} />
<Shows {shows} {locale} />
<TaggedNews {news} {locale} entityType="event" />
