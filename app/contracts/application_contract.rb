class ApplicationContract < Dry::Validation::Contract
  config.messages.top_namespace = "dry_validation"
  config.messages.backend        = :i18n
  config.messages.default_locale = :en
  config.messages.load_paths     << "config/locales/en.yml"

  def self.call(...)
    new.call(...)
  end
end
