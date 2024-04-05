class ApiSpecGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("templates", __dir__)

  def create_api_spec_file
    template 'api_spec.rb.erb', "test/integration/#{file_name}_api_test.rb"
  end
end
