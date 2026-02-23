*** Settings ***
Documentation     Keywords for interacting with the SauceDemo login page.
Library           Browser

*** Variables ***
${LOGIN_USERNAME_FIELD}     id=user-name
${LOGIN_PASSWORD_FIELD}     id=password
${LOGIN_BUTTON}             id=login-button
${LOGIN_ERROR_CONTAINER}    css=.error-message-container

*** Keywords ***
Login With Credentials
    [Documentation]    Fill in username and password, then click the login button.
    [Arguments]    ${username}    ${password}
    Fill Text    ${LOGIN_USERNAME_FIELD}    ${username}
    Fill Text    ${LOGIN_PASSWORD_FIELD}    ${password}
    Click    ${LOGIN_BUTTON}

Login Should Succeed
    [Documentation]    Verify that the user has been redirected to the products page after login.
    Get Url    *=    /inventory.html

Login Should Fail With Message
    [Documentation]    Verify that an error message is displayed on the login page.
    [Arguments]    ${expected_message}
    Get Text    ${LOGIN_ERROR_CONTAINER}    contains    ${expected_message}
