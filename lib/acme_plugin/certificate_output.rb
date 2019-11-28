module AcmePlugin
  class CertificateOutput
    def initialize(domain, cert, csr)
      @csr = csr
      @certificate = cert
      @domain = domain
    end

    def output
      display_info

      output_cert('certificate.pem', @certificate)
      output_cert('key.pem', @csr.private_key)
    end
  end
end
