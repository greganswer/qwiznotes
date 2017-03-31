Feature: Password reset
  As a user
  In order to login if I forgot my password
  I need to reset my password

  Background: I'm a guest with an account
    Given I have an account
    And I'm on the home page
    And I click the "Log in" button
    And I click the "Forgot your password" button

  Scenario: I enter valid email address and fill password form correctly
    When I fill out the send password instructions form correctly
    And I should receive a password reset email and be able to click the button
    When I fill out the password update form correctly
    Then I should see that my password was reset and I'm logged in

  Scenario: I enter valid email address and fill out password form incorrectly
    When I fill out the send password instructions form correctly
    And I should receive a password reset email and be able to click the button
    When I fill out the password update form incorrectly
    And I should see that I'm not logged in

  Scenario: I enter the wrong email address
    When I fill out the send password instructions form incorrectly
    Then I should see the email not found error message
