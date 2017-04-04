Feature: Legal pages
  As a user
  I need to view the legal pages
  So I can know my legal rights on this site

  Background:
    Given I am on the home page

  Scenario: I view the terms of service
    When I click the "Terms of service" link
    Then I should see the "Terms of service" page

  Scenario: I view the privacy policy
    When I click the "Privacy policy" link
    Then I should see the "Privacy policy" page
