# frozen_string_literal: true

# Base mailer for other mailers to inherit behavior from
class ApplicationMailer < ActionMailer::Base
  default from: 'notifications@expiration.xyz'
  layout 'mailer'
end
