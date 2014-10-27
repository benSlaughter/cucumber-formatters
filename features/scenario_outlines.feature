Feature: Scenario outline tests
  Background: This Background passes
    Given this step passes

  Scenario Outline: Scenario outine all passes
    When this step passes <test>
    Then this step passes <test>

    Examples:
      | test |
      | 1234 |

  Scenario Outline: Scenario outine when fails
    When this step fails <test>
    Then this step passes <test>

    Examples:
      | test |
      | 1234 |

  Scenario Outline: Scenario outine then fails
    When this step passes <test>
    Then this step fails <test>

    Examples:
      | test |
      | 1234 |

  Scenario Outline: Scenario outine all pass
    When this step passes
    Then this step will <result>

    Examples:
      | result |
      | pass   |
      | pass   |

  Scenario Outline: Scenario outine first failure
    When this step passes
    Then this step will <result>

    Examples:
      | result |
      | pass   |
      | fail   |

  Scenario Outline: Scenario outine second failure
    When this step passes
    Then this step will <result>

    Examples:
      | result |
      | fail   |
      | pass   |

  Scenario Outline: Scenario outine all failure
    When this step passes
    Then this step will <result>

    Examples:
      | result |
      | fail   |
      | fail   |