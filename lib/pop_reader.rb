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
    mail = Mail.read_from_string(mail)

    body = mail.multipart? ?
      mail.parts.detect { |p| p.content_type.include? 'text/plain' } :
      mail

    return {
      subject: mail.subject,
      to: mail.to.first,
      from: mail.from.first,
      body: body&.decoded || 'failed to decode mail',
    }
  end

end
