ignore([%r{^(bin|config|db|lib|log|public|tmp)/*}])

# Terminal notifier for OSX
notification :terminal_notifier, activate: 'com.googlecode.iTerm2' if `uname` =~ /Darwin/

## RSPEC

guard :rspec, cmd: "spring rspec -fd --color" do
  ## Application classes
  watch("app/controllers/application_controller.rb") { "spec/controllers" }
  watch("app/models/application_record.rb") { |_m| "spec/models" }

  ## Catch-all
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^app/(.+)\.rb$}) { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^app/(.*)(\.erb|\.haml|\.slim)$}) { |m| "spec/#{m[1]}#{m[2]}_spec.rb" }
  watch(%r{^lib/(.+)\.rb$}) { |m| "spec/lib/#{m[1]}_spec.rb" }
end

## CUCUMBER

cucumber_options = {
  cmd: 'spring cucumber',
  cmd_additional_args: '--format html --out cucumber_features.html'
}
guard :cucumber,  cucumber_options do
  watch(%r{^features/(.+)\.feature$}) { |m| "features/#{m[1]}.feature" }
  # watch(%r{^features/support/.+$}) { 'features' }
  # watch(%r{^app/controllers/(.+)_controller\.rb$}) { |m| "features/#{m[1]}" }
  watch(%r{^app/views/devise/.+$}) { "features/authentication/" }
  watch(%r{^features/step_definitions/(.+)_steps\.rb$}) { |m| "features/#{m[1]}.feature" }
end
