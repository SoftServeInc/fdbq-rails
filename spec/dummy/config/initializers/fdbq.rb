Fdbq.configure do |config|
  config.config_file_path = Rails.root.join('config', 'fdbq.yml').to_s

  config.param_key = :feedback

  config.controller_extensions = proc do
    include ExtLogger
  end

  config.model_extensions = proc do
    include ExtensionTestable
  end
end
