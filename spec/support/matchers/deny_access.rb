RSpec::Matchers.define :deny_access do
  match do |actual|
    redirect_to Rails.application.routes.url_helpers.root_path
  end
  
  failure_message_for_should do |actual|
    "expected to deny access to the method"
  end

  failure_message_for_should_not do |actual|
    "expected not to deny access to the method"
  end
  
  description do
    "redirect to root"
  end
end