Feature: Scenario tests
  Background: This Background passes
    Given this step passes

  Scenario: Scenario when fails
    When this step fails
    Then this step passes

  Scenario: Scenario then fails
    When this step passes
    Then this step fails