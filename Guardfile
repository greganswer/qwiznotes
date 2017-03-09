ignore([%r{^(bin|config|db|lib|log|public|tmp)/*}])
# ignore([%r{^bin/*}, %r{^config/*}, %r{^db/*}, %r{^lib/*}, %r{^log/*}, %r{^public/*}, %r{^tmp/*}])

# Terminal notifier for OSX
notification :terminal_notifier, activate: 'com.googlecode.iTerm2' if `uname` =~ /Darwin/

guard :rspec, cmd: "bundle exec rspec" do
  ## Application  classes
  watch("app/actions/application_action.rb") { |_m| "spec/actions" }
  watch("app/controllers/application_controller.rb") { "spec/controllers" }
  watch("app/models/application_record.rb") { |_m| "spec/models" }
  watch("app/policies/application_policy.rb") { |_m| "spec/policies" }

  ## Catch-all
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^app/(.+)\.rb$}) { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^app/(.*)(\.erb|\.haml|\.slim)$}) { |m| "spec/#{m[1]}#{m[2]}_spec.rb" }
  watch(%r{^lib/(.+)\.rb$}) { |m| "spec/lib/#{m[1]}_spec.rb" }
end

guard 'cucumber', cmd: 'bundle exec cucumber' do
  watch(%r{^features/.+\.feature$})
  watch(%r{^features/support/.+$}) { 'features' }
  watch(%r{^app/controllers/(.+)_controller\.rb$}) { |m| "features/#{m[1]}" }
  watch(%r{^features/step_definitions/(.+)_steps\.rb$}) { |m| "features/#{m[1]}" }
  watch(%r{^app/views/(.+)/(.+)\.html\.haml$}) { |m| "features/#{m[1]}" }
end
