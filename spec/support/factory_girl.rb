RSpec.configure do |config|
  # Before tests
  config.before(:suite) do
    FactoryGirl.reload
  end

  # Use `create` instead of `FactoryGirl.create`
  config.include FactoryGirl::Syntax::Methods

  # Track all factories and how they're used throughout test suite
  factory_girl_results = {}
  config.before(:suite) do
    ActiveSupport::Notifications.subscribe("factory_girl.run_factory") do |_name, _start, _finish, _id, payload|
      factory_name = payload[:name]
      strategy_name = payload[:strategy]
      factory_girl_results[factory_name] ||= {}
      factory_girl_results[factory_name][strategy_name] ||= 0
      factory_girl_results[factory_name][strategy_name] += 1
    end
  end

  # After tests
  config.after(:suite) do
    puts factory_girl_results
  end
end
