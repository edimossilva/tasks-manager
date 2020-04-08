Apipie.configure do |config|
  config.app_name                = "Task Manager"
  config.api_base_url            = "/api"
  config.doc_base_url            = "/apipie"
  config.app_info                = "half minute and a half"
  # where is your API defined?
  config.translate = false
  config.validate_value = false
  config.validate_presence = false
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/**/*.rb"
end
