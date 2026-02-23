*** Settings ***
# The Settings section is where you configure your test suite.
# - Documentation: describes what this suite tests
# - Library: imports a test library (Browser = Playwright-based web testing)
Documentation     Your first Robot Framework Browser Library test.
...               This file demonstrates the basic structure of a .robot file.
...               Every .robot file can have these sections:
...               - *** Settings ***    → imports, suite config
...               - *** Variables ***   → reusable values
...               - *** Test Cases ***  → the actual tests
...               - *** Keywords ***    → custom reusable steps
Library           Browser

*** Variables ***
# Variables are defined with ${NAME} syntax.
# They make tests more maintainable — change the URL in one place.
${URL}    https://www.saucedemo.com

*** Test Cases ***
# Each test case starts with a name (no indentation).
# Steps are indented by at least 2 spaces (or a tab).
# Arguments are separated from keywords by 2+ spaces.

Page Title Should Be Swag Labs
    [Documentation]    Open SauceDemo and verify the page title.
    # New Browser creates a browser instance. chromium/firefox/webkit are supported.
    # headless=${True} means no visible window — faster and works in CI.
    New Browser    chromium    headless=${True}
    # New Context creates a browser context (like an incognito session).
    New Context
    # New Page opens a new tab and navigates to the URL.
    New Page    ${URL}
    # Get Title retrieves the page title and compares it.
    # The == operator means "should equal exactly".
    Get Title    ==    Swag Labs
    # Always clean up after your tests.
    Close Browser

Login Page Should Have Username Field
    [Documentation]    Verify that the login page contains a username input field.
    New Browser    chromium    headless=${True}
    New Context
    New Page    ${URL}
    # Get Element checks that a CSS selector matches an element on the page.
    # "id=user-name" is a selector — it finds <input id="user-name">.
    Get Element    id=user-name
    Close Browser

Login Page Should Have Password Field
    [Documentation]    Verify that the login page contains a password input field.
    New Browser    chromium    headless=${True}
    New Context
    New Page    ${URL}
    Get Element    id=password
    Close Browser
