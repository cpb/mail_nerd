@disable-bundler
Feature: Mailer Generator

  Background: Installed and Configured
    Given a rails application
    And I append to "Gemfile" with:
    """
    gem 'mail_nerd', path: '../../../'
    """
    And I run `bundle install`
    And I configure mail_nerd for Mandrill

  Scenario: Generating a Mandrill Mailer
    Given the Mandrill template "Pant Review" is:
    """yaml
    ---
    from_email: Chuck@Headwig.com
    from_name: Chuck Headwig
    subject: Love your pants man!
    code: |
      <p mc:edit="pant_review">They're swell</p>
    publish: false
    """
    When I successfully run `bundle exec rails g mail_nerd:mailer Reviews 'Pant Review'`
    Then the file "app/mailers/reviews.rb" should contain exactly:
    """ruby
    class Reviews < MandrillMailer::TemplateMailer
      default from:      "Chuck@Headwig.com",
              from_name: "Chuck Headwig"

      def pant_review(pant_review="They're swell", recipients=[{email: "guest@honor.com", name: 'Honored Guest'}])
        mandrill_mail template: "Pant Review",
          subject: I18n.t("reviews.pant_review.subject", default: "Love your pants man!"),
          to: recipients,
          vars: {
            pant_review: pant_review
          },
          important: true,
          inline_css: true
      end

      test_setup_for :pant_review do |mailer, options|
        mailer.pant_review(*options.values_at(:pant_review), [options.select{|k| [:name,:email].include?(k)}]).deliver
      end
    end

    """
