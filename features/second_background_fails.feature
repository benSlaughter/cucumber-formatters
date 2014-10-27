Feature: Background failing on second test
  Background: This Background fails
    Given this step fails on tag

  Scenario: All passes
    When this step passes
    Then this step passes

  @fail
  Scenario: Background should fail
    When this step passes
    Then this step passes

  Scenario: All passes
    When this step passes
    Then this step passes