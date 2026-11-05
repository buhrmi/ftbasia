Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  get "/shows/far-too-loud", to: redirect("/events/tokyo-bass-conference"), status: :moved_permanently
  get "/events/far-too-loud", to: redirect("/events/tokyo-bass-conference"), status: :moved_permanently
  get "/artists/stefan", to: redirect("/artists/danangbassman"), status: :moved_permanently
  get "/en/shows/far-too-loud", to: redirect("/en/events/tokyo-bass-conference"), status: :moved_permanently
  get "/en/events/far-too-loud", to: redirect("/en/events/tokyo-bass-conference"), status: :moved_permanently
  get "/en/artists/stefan", to: redirect("/en/artists/danangbassman"), status: :moved_permanently

  root "home#index", defaults: { locale: "ja" }
  get "/en", to: "home#index", defaults: { locale: "en" }, as: :english_root

  scope defaults: { locale: "ja" } do
    get "/artists", to: "artists#index", as: :artists
    get "/artists/:slug", to: "artists#show", as: :artist
    get "/events", to: "events#index", as: :events
    get "/events/:slug", to: "events#show", as: :event
    get "/news", to: "news#index", as: :news
    get "/news/:slug", to: "news#show", as: :news_article
    get "/partners", to: "partners#show", as: :partners
  end

  scope "/en", defaults: { locale: "en" } do
    get "/artists", to: "artists#index", as: :english_artists
    get "/artists/:slug", to: "artists#show", as: :english_artist
    get "/events", to: "events#index", as: :english_events
    get "/events/:slug", to: "events#show", as: :english_event
    get "/news", to: "news#index", as: :english_news
    get "/news/:slug", to: "news#show", as: :english_news_article
    get "/partners", to: "partners#show", as: :english_partners
  end
end
