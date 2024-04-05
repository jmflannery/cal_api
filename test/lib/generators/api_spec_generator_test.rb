require "test_helper"
require "generators/api_spec/api_spec_generator"

describe ApiSpecGenerator do
  tests ApiSpecGenerator
  destination Rails.root.join("tmp/generators")
  setup :prepare_destination

  it 'generates an API spec' do
    run_generator ["nifty_things"]

    assert_file "test/integration/nifty_things_api_test.rb" do |content|
      assert_match(/describe "NiftyThings API" do/, content)
    end
  end
end
