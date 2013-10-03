begin
  raw_config = File.read("#{Rails.root}/config/mail_nerd_config.yml")
  MAIL_NERD_CONFIG = YAML.load(raw_config)[Rails.env].symbolize_keys
rescue => e
  warn "You haven't configured mail_nerd for #{Rails.env}"
end
