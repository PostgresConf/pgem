require_relative 'external_request'

RSpec.configure do |config|

  config.before(:suite) do
    if ENV['OSEM_FACTORY_LINT'] != 'false'
      mock_commercial_request
      FactoryBot.lint
    end
  end

end
