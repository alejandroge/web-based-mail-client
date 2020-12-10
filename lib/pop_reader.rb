require 'net/pop'

class PopReader
  attr_accessor :pop

  def initialize
    @pop = Net::POP3.new('pop.gmail.com').tap do |p|
      p.enable_ssl
    end
  end

  def fetch_new_emails
    pop.start(
      Rails.application.credentials.google[:email],
      Rails.application.credentials.google[:password]
    )
    if pop.mails.empty?
      puts 'No mail.'
    else
      i = 0
      pop.each_mail do |m|
        Email.create(parse_text_email(m.pop))
        m.delete
        i += 1
      end
      puts "#{pop.mails.size} mails popped."
    end
    pop.finish
  end

private
  def parse_text_email(mail)
    subject = /Subject: (.*)\n/.match(mail).captures.first.strip
    from = /From: (.*)\n/.match(mail).captures.first.strip
    to = /To: (.*)\n/.match(mail).captures.first.strip

    boundary = /boundary=\"(.*)\"/.match(mail)&.captures&.first
    body = /text\/plain; charset=\"UTF-8\"([\s\S]*)/s.match(mail)&.captures&.first
    body = body&.split(/--#{boundary}/)&.first&.strip

    return {
      subject: subject,
      to: to,
      from: from,
      body: body || 'failed to fetch body'
    }
  end

end