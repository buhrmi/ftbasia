class PartnersController < InertiaController
  def show
    title = I18n.locale == :ja ? "会場パートナー" : "Venue partnerships"
    description = I18n.locale == :ja ?
      "会場オーナー・マネージャーの皆さまへ。Follow The Bassのイベント開催についてご相談ください。" :
      "Bring a Follow The Bass night to your venue. Get in touch to explore an event partnership."

    render inertia: { meta: page_meta(title, description, "/partners") }
  end
end
