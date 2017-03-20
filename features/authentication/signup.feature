Feature: Sign up
  As a user
  In order to access additional content
  I need to sign up for an account

  Background: I'm a guest
    And I'm on the home page
    And I click the "Sign up" button

  @javascript
  Scenario: I enter valid input
    When I fill out the sign up form correctly
    Then I should see that I signed up successfully
    And I should receive a confirmation email and be able to confirm my account
