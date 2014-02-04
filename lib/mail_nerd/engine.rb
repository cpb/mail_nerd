module MailNerd
  class Engine < ::Rails::Engine
    begin
      isolate_namespace MailNerd
    rescue NoMethodError => e
      warn "how to isolate namespace?"
    end
  end
end
