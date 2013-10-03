class <%= mailer_class_name %> < MandrillMailer::TemplateMailer
  default from: 'support@example.com'

  def group_invite(my_region="foobar", recipients=[{email: invitation.email, name: 'Honored Guest'}])
    mandrill_mail template: 'Group Invite',
      subject: I18n.t('invitation_mailer.group_invite.subject'),
      to: recipients,
      vars: {
        my_region: my_region
      },
      important: true,
      inline_css: true
  end
end
