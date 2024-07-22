#author: Jorge Franco
#date: 22/07/2024

Feature: Get geographical data of a country

  Background:
    * url api.baseUrl
    * path geoPatch = '/timezoneJSON'
    * params {username: "#(user.name)", formatted: true, lat: #(latitude), lng: #(longitude)}
    * def responseSuccessful = read("successful-response-get.json")
    * def responseDataCostaRica = read("response-data-costa-rica-get.json")
    * def responseErrorParameter = read("error-parsing-parameter-get.json")
    * def invalidLatIng = read("invalid-lat-lng.json")

  Scenario Outline: Get geographical data of a country
    When method GET
    Then status 200
    And match $ == responseSuccessful

    Examples:
      | latitude | longitude |
      | 10       | -85       |
      | 8        | -8        |
      | 4.2      | -72.5     |
      | 0        | -72       |
      | 8        | -8f       |
      | -75      | 80        |

  Scenario Outline: Get geographical data of Costa Rica
    When method GET
    Then status 200
    And match $ == responseDataCostaRica

    Examples:
      | latitude | longitude |
      | 10       | -85       |

  Scenario Outline: Get geographical data of a country with parameters invalid
    When method GET
    Then status 200
    And match $ == responseErrorParameter

    Examples:
      | latitude | longitude |
      | abc      | -85       |
      | 10       | abc       |
      | .,       | -85       |
      | 10       | .,        |
      | $%&      | -85       |
      | 10       | $%&       |
      | a10      | -85       |
      | 10       | a8        |

  Scenario Outline: Get geographical data of a country with latitude and longitude invalid
    When method GET
    Then status 200
    And match $ == invalidLatIng

    Examples:
      | latitude | longitude |
      | 10        | 900       |
      | 800      | -85       |

  Scenario Outline: Get geographical data of a country with missing parameter
    When method GET
    Then status 200
    And match $ == {"status": { "message": "missing parameter ", "value": 14 }}

    Examples:
      | latitude | longitude |
      |          | -85       |
      | 10        |           |

  Scenario Outline: Get geographical data of a country that does not have information
    When method GET
    Then status 200
    And match $ == {"status": { "message": "no timezone information found for lat/lng", "value": 15 }}

    Examples:
      | latitude | longitude |
      | 90       | 70        |
      | 90       | 99        |