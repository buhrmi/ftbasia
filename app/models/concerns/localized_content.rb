module LocalizedContent
  extend ActiveSupport::Concern

  def localized(attribute, locale = I18n.locale)
    value = public_send(attribute)
    return value unless value.is_a?(Hash)

    value[locale.to_s].presence || value["ja"].presence || value.values.find(&:present?)
  end
end
