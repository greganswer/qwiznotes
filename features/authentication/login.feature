Feature: Login
  As a user
  In order to access additional content
  I need to log in

  Background: I'm a guest with an account
    Given I have an account
    And I'm on the home page
    And I click the "Log in" button

  @javascript
  Scenario: I enter valid credentials
    When I log in with valid credentials
    Then I should see that I'm logged in
    And I should be able to log out

  Scenario: I enter the wrong wrong credentials
    When I enter the wrong email address
    Then I should see that I'm not logged in
    When I enter the wrong password
    Then I should see that I'm not logged in

  @javascript
  Scenario: Almost locked out
    When I enter the wrong password 9 times
    And I log in with valid credentials
    Then I should see that I'm logged in

  Scenario: Locked out
    When I enter the wrong password 10 times
    And I log in with valid credentials
    Then I should see that I've been locked out
