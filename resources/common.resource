*** Settings ***
Documentation     Shared setup/teardown and common variables for SauceDemo tests.
Library           Browser

*** Variables ***
${BASE_URL}           https://www.saucedemo.com
${VALID_USER}         standard_user
${VALID_PASSWORD}     secret_sauce

*** Keywords ***
Open SauceDemo
    [Documentation]    Launch a headless browser, create a context and page, and navigate to SauceDemo.
    New Browser    chromium    headless=${True}
    New Context
    New Page    ${BASE_URL}

Close SauceDemo
    [Documentation]    Close all browsers opened during the test.
    Close Browser    ALL
