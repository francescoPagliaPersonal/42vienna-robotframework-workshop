*** Settings ***
Documentation     Minimal test to verify the environment is working.
...               This is the FIRST test you should run after setting up.
...               If this passes, your environment is ready for the workshop.
Library           Browser

*** Test Cases ***
Verify Browser Library Can Open SauceDemo
    [Documentation]    Opens a headless browser, navigates to SauceDemo,
    ...                verifies the page loads, and takes a screenshot.
    New Browser    chromium    headless=${True}
    New Context
    New Page    https://www.saucedemo.com
    Get Title    ==    Swag Labs
    Take Screenshot
    Close Browser
