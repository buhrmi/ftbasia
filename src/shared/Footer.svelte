<script>
	import { page } from '$app/state';

	const REPOSITORY_URL = 'https://github.com/buhrmi/ftbasia';

	let { locale = 'ja' } = $props();

	const copy = $derived(
		locale === 'ja'
			? {
					openSource: 'Follow The Bassのウェブサイトはオープンソースです。',
					report: 'このページの問題を報告する',
					venueLabel: '会場オーナー・マネージャーの皆さまへ',
					venueHeading: 'Follow The Bassのイベントを開催しませんか？',
					venueDescription: '会場パートナーとして、一緒に特別な夜を作りましょう。',
					venueCta: 'パートナーについて'
				}
			: {
					openSource: 'The Follow The Bass website is open source.',
					report: 'Report an issue with this page',
					venueLabel: 'For venue owners and managers',
					venueHeading: 'Host a Follow The Bass night',
					venueDescription: 'Partner with us to bring an unforgettable bass music event to your venue.',
					venueCta: 'Explore venue partnerships'
				}
	);
	const partnersUrl = $derived(locale === 'ja' ? '/partners' : '/en/partners');

	const issueUrl = $derived.by(() => {
		const currentUrl = page.url.pathname;
		const params = new URLSearchParams({
			title: `Issue on ${currentUrl}`,
			body: `**Page:** ${currentUrl}\n\n<!-- What went wrong? -->\n`
		});

		return `${REPOSITORY_URL}/issues/new?${params}`;
	});

	const socials = [
		{ label: 'X', href: 'https://www.x.com/ftbasia', icon: 'i-simple-icons-x' },
		{
			label: 'Instagram',
			href: 'https://www.instagram.com/ftb.asia',
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
	<section class="venue-cta" aria-labelledby="footer-venue-cta-heading">
		<div>
			<p class="venue-cta__label">{copy.venueLabel}</p>
			<h2 id="footer-venue-cta-heading">{copy.venueHeading}</h2>
			<p class="venue-cta__description">{copy.venueDescription}</p>
		</div>
		<a href={partnersUrl}>
			{copy.venueCta}
			<span aria-hidden="true">→</span>
		</a>
	</section>

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

<style>
	.venue-cta {
		display: flex;
		align-items: center;
		justify-content: space-between;
		gap: 1.5rem;
		margin-block: 1.5rem;
		border: 1px solid rgb(201 239 106 / 25%);
		border-radius: 0.75rem;
		background: linear-gradient(110deg, rgb(201 239 106 / 8%), rgb(255 255 255 / 2%));
		padding: 1.25rem 1.5rem;
	}

	.venue-cta__label {
		margin: 0 0 0.35rem;
		color: #b8d978;
		font-size: 0.6875rem;
		font-weight: 600;
		letter-spacing: 0.12em;
		text-transform: uppercase;
	}

	.venue-cta h2 {
		margin: 0;
		font-size: clamp(1.1rem, 3vw, 1.4rem);
		font-weight: 600;
		line-height: 1.35;
	}

	.venue-cta__description {
		margin: 0.4rem 0 0;
		color: #a3a3a3;
		font-size: 0.8rem;
		line-height: 1.5;
	}

	.venue-cta a {
		display: inline-flex;
		flex: 0 0 auto;
		align-items: center;
		gap: 0.55rem;
		border-radius: 9999px;
		background: #d7f58c;
		padding: 0.75rem 1rem;
		color: #111;
		font-size: 0.75rem;
		font-weight: 700;
		text-decoration: none;
		transition: background-color 160ms ease, transform 160ms ease;
	}

	.venue-cta a:hover {
		transform: translateY(-1px);
		background: #e5ffab;
	}

	.venue-cta a:focus-visible {
		outline: 2px solid white;
		outline-offset: 4px;
	}

	@media (max-width: 560px) {
		.venue-cta {
			align-items: flex-start;
			flex-direction: column;
			gap: 1rem;
		}
	}
</style>
