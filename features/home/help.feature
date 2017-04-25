Feature: Help
  As a user
  I need to contact a site administrator
  So I can get help with my current problem

  Scenario: I am a guest
    Given I am on the home page
    When I click the "Help" button
    And I fill in the contact form
    Then I should see that the contact message was sent

  Scenario: I am logged in
    Given I am logged in
    And I am on the home page
    When I click the "Help" button
    And I fill in the message field of the contact form
    Then I should see that the contact message was sent

  Scenario: I am a guest and I don't fill in the email field
    Given I am on the home page
    When I click the "Help" button
    And I fill in the contact form
    Then I should see that the contact message was sent
