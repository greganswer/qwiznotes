Kaminari.configure do |config|
  config.default_per_page = 24
  config.max_per_page = 48
  config.window = 2
  config.outer_window = 2
  # config.left = 0
  # config.right = 0
  # config.page_method_name = :page
  # config.param_name = :page
end
