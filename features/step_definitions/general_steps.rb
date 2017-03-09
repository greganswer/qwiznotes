Given /^I see (\d+) (.*?) rows$/ do |n, plural_name|
  n = n.to_i
  class_name = plural_name.singularize.parameterize.underscore
  expect(page).to have_css("tbody tr.#{class_name}", count: n)
end

Given /(\d+) (.*?) were already created/ do |n, plural_name|
  n = n.to_i
  create_list(plural_name.singularize, 2)
end
