*** Settings ***
Documentation     Francesco Paglia - get hands dirty with Robot-framework
Library           Browser
Resource          ../../resources/common.resource
Resource          ../../resources/login_page.resource

# Suite Setup       Open SauceDemo
Suite Teardown    Close SauceDemo

*** Variables ***
${LAND_URL}            https://www.saucedemo.com/
${USR_LOGIN}           standard_user
${USR_PWD}             secret_sauce

*** Test Cases ***
Login with standard user
    [Documentation]    login using the valid user outside of the resources
    New Browser    chromium    headless=${True}
    New Context
    New Page        ${LAND_URL}
    Fill Text       id=user-name        ${USR_LOGIN}
    Fill Text        id=password        ${USR_PWD}
    Click            id=login-button
    Get Url     *=  /inventory.html
    [Tags]    student    exercise
    # Write your test steps here
    Log    to define what it happens
    Close SauceDemo
