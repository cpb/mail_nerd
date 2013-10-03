# MailNerd

I really do not like sending html emails. However, I understand the value proposition: more engaging, better brand experience. What I do not want is to integrate that complexity into my codebases. The mail templates are going to change some day, I would prefer to externalize that from the development of my core applications. I want to delegate to a service that will render and maintain versions of my email templates.

Therefore, I should be able to capture the utility in an Engine. The emails I want to deliver don't belong here. They belong in that remote service.

## Installation

Add this to your Gemfile:

```ruby
gem 'mail_nerd'
```

Then install it by running Bundler:

```bash
$ bundle
```

## Configuration

At this time, your options are:

* [Mandrill](https://mandrillapp.com)
 * [Click here to create an API Key](https://mandrillapp.com/settings/add-key)

Now, from the Rails project you've installed this engine in, use the ```mail_nerd:configure``` rake task. It will prompt you through setting up your mail_nerd configuration.

```bash
$ rake mail_nerd:configure
> What's the host of the service? smtp.mandrillapp.com
> What's the port of the service? 587
> What's your username for the service? # Usually the email of the account you signed up with.
> What's your password for the service? # You just generated this with the above link

Thanks!

* Checking authentication...
> Great! The settings work. Do you want to use this for your current rails environment? [Default: development]
* Writing to configuration file...

Done!
```

This project rocks and uses MIT-LICENSE.
