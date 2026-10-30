<script>
	import { page } from 'inertiax-svelte';

	const REPOSITORY_URL = 'https://github.com/buhrmi/ftbasia';

	const locale = $derived(page.props.locale ?? 'en');

	const copy = $derived(
		locale === 'ja'
			? {
					openSource: 'Follow The Bassのウェブサイトはオープンソースです。',
					report: 'このページの問題を報告する'
				}
			: {
					openSource: 'The Follow The Bass website is open source.',
					report: 'Report an issue with this page'
				}
	);

	const issueUrl = $derived.by(() => {
		const params = new URLSearchParams({
			title: `Issue on ${page.url}`,
			body: `**Page:** ${page.url}\n\n<!-- What went wrong? -->\n`
		});

		return `${REPOSITORY_URL}/issues/new?${params}`;
	});

	const socials = [
		{ label: 'X', href: 'https://www.x.com/ftbasia', icon: 'i-simple-icons-x' },
		{
			label: 'Instagram',
			href: 'https://www.instagram.com/ftbasia',
			icon: 'i-simple-icons-instagram'
		},
		{
			label: 'YouTube',
			href: 'https://www.youtube.com/@followthebass',
			icon: 'i-simple-icons-youtube'
		},
		{ label: 'Twitch', href: 'https://www.twitch.tv/followthebass', icon: 'i-simple-icons-twitch' },
		{
			label: 'Facebook',
			href: 'https://www.facebook.com/profile.php?id=61591551076334',
			icon: 'i-simple-icons-facebook'
		},
		{ label: 'TikTok', href: 'https://www.tiktok.com/@followthebass_', icon: 'i-simple-icons-tiktok' }
	];

</script>

<footer class="pb-10">

	<div class="flex flex-wrap items-center justify-between gap-4 border-t border-white/10 py-6">
		<p class="text-xs text-neutral-500">
			<a
				href={REPOSITORY_URL}
				target="_blank"
				rel="noreferrer"
				class="underline underline-offset-4 transition-colors hover:text-white"
			>
				{copy.openSource}
			</a>
		</p>
		<a
			href={issueUrl}
			target="_blank"
			rel="noreferrer"
			class="inline-flex items-center gap-2 rounded-full border border-white/20 px-4 py-2 text-xs text-neutral-300 transition-colors hover:border-white/40 hover:text-white"
		>
			<span class="i-simple-icons-github text-sm" aria-hidden="true"></span>
			{copy.report}
		</a>
	</div>

	<div class="flex flex-wrap items-center justify-between gap-4 border-t border-white/10 py-6">
		<p class="text-[11px] tracking-[0.25em] text-neutral-500 uppercase">&copy; Follow The Bass</p>
		<ul class="flex items-center gap-5">
			{#each socials as social (social.label)}
				<li>
					<a
						href={social.href}
						target="_blank"
						rel="noreferrer"
						aria-label={social.label}
						class="block text-lg text-neutral-500 transition-colors hover:text-white"
					>
						<span class="inline-block {social.icon}" aria-hidden="true"></span>
					</a>
				</li>
			{/each}
		</ul>
	</div>
</footer>
