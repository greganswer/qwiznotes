Feature: Sign up
  As a user
  I need to sign up for an account
  So I can access additional content

  Background: I am a guest
    And I am on the home page
    And I click the "Sign up" button
    And I see the "Agree to our terms and privacy" text

  @javascript
  Scenario: I enter valid input
    When I fill out the sign up form correctly
    Then I should see that I am signed up
    And I should receive a confirmation email and be able to confirm my account

  Scenario: I enter the wrong credentials
    When I leave the email address blank
    Then I should see that I am not signed up
    When I leave the password blank
    Then I should see that I am not signed up
