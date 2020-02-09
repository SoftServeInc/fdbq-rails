Fdbq.configure do |config|
  config.config_file_path = Rails.root.join('config', 'fdbq.yml').to_s

  config.param_key = :feedback

  # config.controller_extensions do
  #   # extend controller
  # end

  # config.model_extensions do
  #   # extend model
  # end
end
