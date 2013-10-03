Rails.application.routes.draw do

  mount MailNerd::Engine => "/mail_nerd"
end
