require 'test_helper'

class AcmePluginTest < ActiveSupport::TestCase
  ACME_VERSION = 'v2.0.5'.freeze
  ACME_USER_AGENT = "Acme::Client #{ACME_VERSION} (https://github.com/unixcharles/acme-client)".freeze
  DIRECTORY_URL = 'https://acme-staging-v02.api.letsencrypt.org/directory'.freeze
  API_URL = "#{DIRECTORY_URL}".freeze
  PRIVATE_KEY = %(
-----BEGIN RSA PRIVATE KEY-----
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
-----END RSA PRIVATE KEY-----).freeze

  def setup
    WebMock.disable_net_connect!(allow_localhost: true)
  end

  def teardown
    WebMock.allow_net_connect!
  end

  test 'is_valid_module' do
    assert_kind_of Module, AcmePlugin
  end

  test 'if_fail_when_private_key_is_nil' do
    exception = assert_raises RuntimeError do
      cg = AcmePlugin::CertGenerator.new(private_key: nil, directory: DIRECTORY_URL)
      cg.client
    end
    assert_equal 'Private key is not set, please check your config/acme_plugin.yml file!', exception.message
  end

  test 'if_fail_when_private_key_is_empty' do
    exception = assert_raises RuntimeError do
      cg = AcmePlugin::CertGenerator.new(private_key: '', directory: DIRECTORY_URL)
      cg.client
    end
    assert_equal 'Private key is not set, please check your config/acme_plugin.yml file!', exception.message
  end

  test 'if_fail_when_private_key_is_directory' do
    options = { private_key: 'public', directory: DIRECTORY_URL }
    exception = assert_raises RuntimeError do
      cg = AcmePlugin::CertGenerator.new(options)
      cg.client
    end
    assert_equal "Can not open private key: #{File.join(Rails.root, options[:private_key])}", exception.message
  end

  test 'if_keysize_smaller_than_2048_is_invalid' do
    exception = assert_raises RuntimeError do
      cg = AcmePlugin::CertGenerator.new(private_key: 'key/test_keyfile_1024.pem', directory: DIRECTORY_URL)
      cg.client
    end
    assert_equal 'Invalid key size: 1024. Required size is between 2048 - 4096 bits', exception.message
  end

  test 'if_keysize_greater_than_4096_is_invalid' do
    exception = assert_raises RuntimeError do
      cg = AcmePlugin::CertGenerator.new(private_key: 'key/test_keyfile_8192.pem', directory: DIRECTORY_URL)
      cg.client
    end
    assert_equal 'Invalid key size: 8192. Required size is between 2048 - 4096 bits', exception.message
  end

  test 'if_keysize_equal_4096_is_valid' do
    assert_nothing_raised do
      cg = AcmePlugin::CertGenerator.new(private_key: 'key/test_keyfile_4096.pem', directory: DIRECTORY_URL)
      assert !cg.nil?
      cg.client
    end
  end

  test 'if_keysize_equal_2048_is_valid' do
    assert_nothing_raised do
      cg = AcmePlugin::CertGenerator.new(private_key: 'key/test_keyfile_2048.pem', directory: DIRECTORY_URL)
      assert !cg.nil?
      cg.client
    end
  end


  test 'register_and_authorize' do
    cg = AcmePlugin::CertGenerator.new(private_key: 'key/test_keyfile_4096.pem',
                                       directory: DIRECTORY_URL,
                                       domain: 'example.com',
                                       email: 'foobarbaz@example.com')
    assert !cg.nil?

    stub_request(:get, "https://acme-staging-v02.api.letsencrypt.org/directory").
      with(  headers: {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'User-Agent'=>'Acme::Client v2.0.5 (https://github.com/unixcharles/acme-client)'
        }).
      to_return(status: 200, body: "", headers: {})

    assert_nothing_raised do
      cg.register
    end
  end
end
