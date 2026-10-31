class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  use_inertia_instance_props

  around_action :switch_locale

  private

  def switch_locale(&action)
    I18n.with_locale(locale_from_params, &action)
  end

  def locale_from_params
    requested = params[:locale].to_s
    I18n.available_locales.map(&:to_s).include?(requested) ? requested : I18n.default_locale
  end

  # Props consumed by the default layout for <title> and social share previews.
  # Pages add their own og:image/twitter:image, since those assets are imported by Vite.
  def page_meta(title:, description: nil, type: "website", published_at: nil)
    {
      title: title,
      description: description.presence,
      canonical_url: absolute_url(request.path),
      origin: request.base_url,
      og_type: type,
      og_locale: t("meta.locale"),
      published_at: published_at
    }.compact
  end

  def absolute_url(path)
    return path if path.to_s.match?(%r{\Ahttps?://})

    "#{request.base_url}#{path}"
  end
end
