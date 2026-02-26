*** Settings ***
Documentation     Shopping cart tests for SauceDemo.
...               Covers adding items, verifying cart contents, removing items,
...               and cart persistence across page navigation.
Library           Browser
Resource          ../../resources/common.resource
Resource          ../../resources/login_page.resource
Resource          ../../resources/products_page.resource
Resource          ../../resources/cart_page.resource

Suite Setup       Login And Open Products
Suite Teardown    Close SauceDemo

Test Setup        Go To    ${BASE_URL}/inventory.html

*** Keywords ***
Login And Open Products
    [Documentation]    Log in with standard user and navigate to products page.
    Open SauceDemo
    Login With Credentials    ${VALID_USER}    ${VALID_PASSWORD}
    Login Should Succeed

*** Test Cases ***
Cart Should Start Empty
    [Documentation]    Before adding items, the cart should be empty.
    Open Cart
    Cart Should Be Empty

Add Item And Verify In Cart
    [Documentation]    Add a product from the catalog and verify it appears in the cart.
    Add Product To Cart    Sauce Labs Backpack
    Open Cart
    Cart Should Contain    Sauce Labs Backpack
    # Clean up
    Go To    ${BASE_URL}/inventory.html
    Remove Product From Cart    Sauce Labs Backpack

Remove Item From Cart
    [Documentation]    Add then remove a product, verify cart is empty.
    Add Product To Cart    Sauce Labs Bolt T-Shirt
    Open Cart
    Cart Should Contain    Sauce Labs Bolt T-Shirt
    Click    css=.cart_item:has-text("Sauce Labs Bolt T-Shirt") button[id^="remove"]
    Cart Should Be Empty

Cart Persists After Continuing Shopping
    [Documentation]    Items should remain in cart after clicking Continue Shopping.
    Add Product To Cart    Sauce Labs Onesie
    Open Cart
    Cart Should Contain    Sauce Labs Onesie
    Continue Shopping
    # We're back on products page — open cart again
    Open Cart
    Cart Should Contain    Sauce Labs Onesie
    # Clean up
    Go To    ${BASE_URL}/inventory.html
    Remove Product From Cart    Sauce Labs Onesie
