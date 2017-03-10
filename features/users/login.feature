Feature: Login
  As a user
  In order to access additional content
  I need to log in

  Background: A guest with an account
    Given I have an account
    And I'm on the home page
    And I click the "Log in" button

  @javascript
  Scenario: Valid credentials
    When I log in with valid credentials
    Then I should see that I'm logged in
    And I can log out

  @javascript
  Scenario: Almost locked out
    When I enter the wrong password 9 times
    And I log in with valid credentials
    Then I should see that I'm logged in

  Scenario: Locked out
    When I enter the wrong password 10 times
    And I log in with valid credentials
    Then I should see that I've been locked out

  Scenario: Wrong email address
    When I enter the wrong email address
    Then I should see that I'm not logged in

  Scenario: Wrong password
    When I enter the wrong password
    Then I should see that I'm not logged in
