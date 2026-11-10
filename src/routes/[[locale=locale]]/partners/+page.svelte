<script>
  import PageMeta from "~/shared/PageMeta.svelte";

  let { data } = $props();

  const japanese = $derived(data.locale === "ja");
</script>

<PageMeta meta={data.meta} />

<main class="partners-page">
  {#if japanese}
    <p class="eyebrow">会場オーナー・マネージャーの皆さまへ</p>
    <h1>あなたの会場で、Follow The Bassの夜を。</h1>
    <p class="intro">
      ベースミュージックのイベント開催にご興味のある会場の皆さま、ぜひご連絡ください。Follow The Bass は、海外アーティストの来日公演に必要な書類、渡航、宿泊、会場対応までをまとめてサポートします。ブッキング自体は提携するブッキング会社が担い、会場様の費用負担はゼロです。
    </p>
    <p class="intro intro--compact">
      回収はチケット収入から。公演が成立しなかった場合の損失も弊社が負担するため、会場様にとってはリスクを最小化できるパートナーです。スペースと雰囲気をお持ちの会場に、実務と費用とリスクを合わせてお任せします。
    </p>

    <div class="partner-grid">
      <article>
        <div class="feature-head">
          <span class="feature-icon i-lucide:messages-square" aria-hidden="true"></span>
          <h2>書類と会場対応をまとめて</h2>
        </div>
        <p>興行ビザ、渡航、会場とのやり取りを日本語・英語の両方で統括し、現場でのすり合わせまで担います。</p>
      </article>
      <article>
        <div class="feature-head">
          <span class="feature-icon i-lucide:shield-check" aria-hidden="true"></span>
          <h2>ビザ・航空券・宿泊は全額弊社負担</h2>
        </div>
        <p>渡航に必要な申請や宿泊、航空券の手配はすべて弊社が対応し、会場様の負担はありません。</p>
      </article>
      <article>
        <div class="feature-head">
          <span class="feature-icon i-lucide:megaphone" aria-hidden="true"></span>
          <h2>集客の見通しとプロモーション</h2>
        </div>
        <p>フライヤー、SNS、コミュニティへの発信まで一体で動き、開催前の集客見通しも共有します。</p>
      </article>
      <article>
        <div class="feature-head">
          <span class="feature-icon i-lucide:clipboard-list" aria-hidden="true"></span>
          <h2>当日の現場対応</h2>
        </div>
        <p>サウンドチェックの調整、アーティストのアテンド、進行やトラブルの対応までこちらで担います。</p>
      </article>
    </div>

    <section class="info-block">
      <h2>募集の流れ</h2>
      <ol>
        <li>ご連絡: 会場名・場所・収容人数をご連絡ください。条件が固まっていなくても大丈夫です。</li>
        <li>現地確認: 実際に会場を拝見し、音響・動線・キャパシティを確認します。</li>
        <li>日程と条件を整理: ブッキング会社とアーティストチームと調整し、公演を実施します。</li>
      </ol>
    </section>

    <section class="info-block">
      <h2>会場様にとっての強み</h2>
      <ul>
        <li>過去の来日公演で、書類と現場の実務を経験しているため、トラブルの予測が立てやすい。</li>
        <li>費用やリスクを会場様に残さず、チケット収入から回収する構造で進められる。</li>
        <li>シーンに根ざした判断で、どの会場が合うか、どの一夜が成立しやすいかを見極められる。</li>
      </ul>
    </section>

    <div class="cta-row">
      <a class="contact-button" href="https://zalo.me/0869344003" target="_blank" rel="noopener noreferrer">
        Zaloでお問い合わせ
        <span aria-hidden="true">→</span>
      </a>
      <a class="secondary-button" href="mailto:start@followthebass.asia?subject=%E4%BC%9A%E5%A0%B4%E3%83%91%E3%83%BC%E3%83%88%E3%83%8A%E3%83%BC%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6">
        メールで相談する
      </a>
    </div>
  {:else}
    <p class="eyebrow">For venue owners and managers</p>
    <h1>Bring a Follow The Bass night to your venue.</h1>
    <p class="intro">
      If you run a venue and are interested in hosting a bass music event, we’d love to hear from you. Follow The Bass handles the full operational side of an overseas artist booking — from paperwork and visas to travel, accommodation, and on-site coordination — while keeping your financial risk at zero.
    </p>
    <p class="intro intro--compact">
      We work with booking partners for artist acquisition, but we take charge of the practical delivery: paperwork, venue communication, flights, accommodation, and day-of execution. The event is financed through ticket revenue, and we absorb the risk if the show does not come together.
    </p>

    <div class="partner-grid">
      <article>
        <div class="feature-head">
          <span class="feature-icon i-lucide:messages-square" aria-hidden="true"></span>
          <h2>Paperwork and venue coordination in one place</h2>
        </div>
        <p>We manage visas, travel arrangements, and venue communication in both Japanese and English so the process stays clear and efficient.</p>
      </article>
      <article>
        <div class="feature-head">
          <span class="feature-icon i-lucide:shield-check" aria-hidden="true"></span>
          <h2>Visa, flights, and lodging covered</h2>
        </div>
        <p>Artist travel, visas, accommodation, and logistics are all handled by us, and your venue is not asked to cover the cost.</p>
      </article>
      <article>
        <div class="feature-head">
          <span class="feature-icon i-lucide:megaphone" aria-hidden="true"></span>
          <h2>Audience strategy and promotion</h2>
        </div>
        <p>We coordinate flyers, social reach, and scene outreach to build momentum before the night begins.</p>
      </article>
      <article>
        <div class="feature-head">
          <span class="feature-icon i-lucide:clipboard-list" aria-hidden="true"></span>
          <h2>On-site support</h2>
        </div>
        <p>We handle soundcheck coordination, artist care, show flow, and day-of troubleshooting so the venue can focus on the experience.</p>
      </article>
    </div>

    <section class="info-block">
      <h2>How it works</h2>
      <ol>
        <li>Reach out: share your venue name, location, and capacity, even if the details are still tentative.</li>
        <li>Review the space: we assess the venue, acoustics, flow, and capacity against the event concept.</li>
        <li>Lock the plan: we align schedules with the booking team and artist side and move into production.</li>
      </ol>
    </section>

    <section class="info-block">
      <h2>Why partner with us</h2>
      <ul>
        <li>We’ve already handled the operational side of overseas artist bookings, so we know what needs to be in place before doors open.</li>
        <li>You avoid carrying the cost or legal risk associated with travel, visas, and last-minute production issues.</li>
        <li>We understand the bass music scene and can help match the right event to the right venue and audience.</li>
      </ul>
    </section>

    <div class="cta-row">
      <a class="contact-button" href="https://zalo.me/0869344003" target="_blank" rel="noopener noreferrer">
        Contact us on Zalo
        <span aria-hidden="true">→</span>
      </a>
      <a class="secondary-button" href="mailto:start@followthebass.asia?subject=Venue%20partnership%20inquiry">
        Email us
      </a>
    </div>
  {/if}
</main>

<style>
  .partners-page {
    max-width: 52rem;
    margin: 2rem auto 5rem;
    padding: 2rem 1.5rem 3rem;
    border: 1px solid rgb(184 217 120 / 18%);
    border-radius: 1.25rem;
    background:
      radial-gradient(circle at top left, rgb(184 217 120 / 12%), transparent 32%),
      linear-gradient(135deg, rgb(255 255 255 / 5%), rgb(255 255 255 / 1%));
    box-shadow: 0 10px 30px rgb(0 0 0 / 15%);
  }

  .eyebrow {
    margin: 0 0 1rem;
    color: #b8d978;
    font-size: 0.6875rem;
    font-weight: 700;
    letter-spacing: 0.14em;
    text-transform: uppercase;
  }

  h1 {
    margin: 0;
    font-size: clamp(2.2rem, 6vw, 3.5rem);
    font-weight: 700;
    letter-spacing: -0.05em;
    line-height: 1.03;
    color: #f8f8f8;
  }

  .intro {
    max-width: 40rem;
    margin: 1.25rem 0 0;
    color: #cdcdcd;
    font-size: 1rem;
    line-height: 1.8;
  }

  .intro--compact {
    margin-top: 1rem;
  }

  .partner-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
    gap: 1rem;
    margin-top: 2rem;
  }

  .partner-grid article,
  .info-block {
    border: 1px solid rgb(255 255 255 / 10%);
    border-radius: 1rem;
    background: linear-gradient(180deg, rgb(255 255 255 / 3%), rgb(255 255 255 / 1.5%));
    padding: 1.1rem 1rem;
  }

  .feature-head {
    display: flex;
    align-items: flex-start;
    gap: 0.75rem;
  }

  .feature-icon {
    display: grid;
    place-items: center;
    width: 2.1rem;
    height: 2.1rem;
    border: 1px solid rgb(184 217 120 / 25%);
    border-radius: 0.75rem;
    background: rgb(184 217 120 / 10%);
    color: #d7f58c;
    font-size: 1rem;
    box-shadow: inset 0 0 0 1px rgb(255 255 255 / 5%);
  }

  .partner-grid h2,
  .info-block h2 {
    margin: 0;
    font-size: 1rem;
    font-weight: 600;
    letter-spacing: -0.02em;
    line-height: 1.4;
    color: #f5f5f5;
  }

  .partner-grid p,
  .info-block li,
  .info-block ol,
  .info-block ul {
    margin: 0.7rem 0 0;
    color: #b3b3b3;
    font-size: 0.95rem;
    line-height: 1.7;
  }

  .info-block {
    margin-top: 1.5rem;
    background: linear-gradient(180deg, rgb(184 217 120 / 3%), rgb(255 255 255 / 2%));
  }

  .info-block ol,
  .info-block ul {
    padding-left: 1.2rem;
  }

  .cta-row {
    display: flex;
    flex-wrap: wrap;
    gap: 0.75rem;
    align-items: center;
    margin-top: 2rem;
  }

  .contact-button,
  .secondary-button {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    gap: 0.65rem;
    border-radius: 9999px;
    padding: 0.85rem 1.25rem;
    font-size: 0.875rem;
    font-weight: 700;
    text-decoration: none;
    transition: background-color 160ms ease, transform 160ms ease, box-shadow 160ms ease;
  }

  .contact-button {
    background: linear-gradient(135deg, #d7f58c, #b8d978);
    color: #111;
    box-shadow: 0 10px 20px rgb(184 217 120 / 18%);
  }

  .secondary-button {
    border: 1px solid rgb(255 255 255 / 12%);
    background: rgb(255 255 255 / 2%);
    color: white;
  }

  .contact-button:hover,
  .secondary-button:hover {
    transform: translateY(-1px);
  }

  .contact-button:hover {
    background: linear-gradient(135deg, #e5ffab, #d5eb8f);
  }

  .secondary-button:hover {
    background: rgb(255 255 255 / 4%);
    box-shadow: 0 10px 20px rgb(0 0 0 / 12%);
  }

  .contact-button:focus-visible,
  .secondary-button:focus-visible {
    outline: 2px solid white;
    outline-offset: 4px;
  }

  @media (max-width: 560px) {
    .partners-page {
      margin-block: 1rem 3rem;
      padding: 1.5rem 1.25rem 2rem;
    }

    .cta-row {
      flex-direction: column;
      align-items: stretch;
    }

    .contact-button,
    .secondary-button {
      width: 100%;
    }
  }
</style>
