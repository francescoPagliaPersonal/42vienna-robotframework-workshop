*** Settings ***
Documentation     Tests for the SauceDemo product catalog / inventory page.
...               Covers product listing, adding items to cart, and sorting.
Library           Browser
Resource          ../../resources/common.resource
Resource          ../../resources/login_page.resource
Resource          ../../resources/products_page.resource

Suite Setup       Login And Open Products
Suite Teardown    Close SauceDemo

*** Keywords ***
Login And Open Products
    [Documentation]    Log in with standard user and navigate to products page.
    Open SauceDemo
    Login With Credentials    ${VALID_USER}    ${VALID_PASSWORD}
    Login Should Succeed

*** Test Cases ***
Products Page Should Display Six Items
    [Documentation]    SauceDemo always shows 6 products in the catalog.
    Product Count Should Be    6

Products Page Should Show Correct Title
    [Documentation]    The inventory page title should be "Products".
    Get Text    css=.title    ==    Products

Add Single Product To Cart
    [Documentation]    Adding a product should show a cart badge with count 1.
    Add Product To Cart    Sauce Labs Backpack
    Cart Badge Should Show    1
    # Clean up — remove the item
    Remove Product From Cart    Sauce Labs Backpack

Add Multiple Products To Cart
    [Documentation]    Adding two products should show cart badge with count 2.
    Add Product To Cart    Sauce Labs Backpack
    Add Product To Cart    Sauce Labs Bike Light
    Cart Badge Should Show    2
    # Clean up
    Remove Product From Cart    Sauce Labs Backpack
    Remove Product From Cart    Sauce Labs Bike Light

Sort Products By Price Low To High
    [Documentation]    Verify that sorting by price low-to-high works.
    Sort Products By    lohi
    # After sorting, first item price should be the lowest ($7.99)
    ${first_price}=    Get Text    css=.inventory_item:first-child .inventory_item_price
    Should Be Equal    ${first_price}    $7.99

Open Product Detail Page
    [Documentation]    Clicking a product name should open its detail page.
    Open Product Details    Sauce Labs Backpack
    Get Text    css=.inventory_details_name    ==    Sauce Labs Backpack
    # Go back to products
    Click    id=back-to-products
