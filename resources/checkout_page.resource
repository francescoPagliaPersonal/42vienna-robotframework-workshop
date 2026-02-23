*** Settings ***
Documentation     Keywords for interacting with the SauceDemo checkout pages.
Library           Browser

*** Variables ***
${FIRST_NAME_FIELD}       id=first-name
${LAST_NAME_FIELD}        id=last-name
${POSTAL_CODE_FIELD}      id=postal-code
${CONTINUE_BUTTON}        id=continue
${FINISH_BUTTON}          id=finish
${CHECKOUT_COMPLETE}      css=.complete-header
${CHECKOUT_ERROR}         css=.error-message-container

*** Keywords ***
Fill Checkout Information
    [Documentation]    Fill in the checkout information form.
    [Arguments]    ${first_name}    ${last_name}    ${postal_code}
    Fill Text    ${FIRST_NAME_FIELD}    ${first_name}
    Fill Text    ${LAST_NAME_FIELD}    ${last_name}
    Fill Text    ${POSTAL_CODE_FIELD}    ${postal_code}
    Click    ${CONTINUE_BUTTON}

Complete Checkout
    [Documentation]    Click the Finish button on the checkout overview page.
    Click    ${FINISH_BUTTON}

Order Should Be Confirmed
    [Documentation]    Verify the order confirmation message is displayed.
    Get Text    ${CHECKOUT_COMPLETE}    ==    Thank you for your order!
