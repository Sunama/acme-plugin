require 'acme_plugin/certificate_output'

module AcmePlugin
  class HerokuOutput < CertificateOutput
    def initialize(domain, cert, csr)
      super(domain, cert, csr)
    end

    def output_cert(cert_type, cert_content)
      Rails.logger.info("====== #{@domain}-#{cert_type} ======")
      puts cert_content
    end

    def display_info
      Rails.logger.info('You are running this script on Heroku, please copy-paste certificates to your local machine')
      Rails.logger.info('and then follow https://devcenter.heroku.com/articles/ssl-endpoint guide:')
    end
  end
end
