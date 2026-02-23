*** Settings ***
Documentation     Keywords for interacting with the SauceDemo products/inventory page.
Library           Browser

*** Variables ***
${PRODUCTS_TITLE}       css=.title
${INVENTORY_LIST}       css=.inventory_list
${INVENTORY_ITEM}       css=.inventory_item
${CART_BADGE}           css=.shopping_cart_badge
${CART_LINK}            css=.shopping_cart_link
${SORT_DROPDOWN}        css=.product_sort_container

*** Keywords ***
Product Count Should Be
    [Documentation]    Verify the number of products displayed on the inventory page.
    [Arguments]    ${expected_count}
    ${items}=    Get Elements    ${INVENTORY_ITEM}
    ${count}=    Get Length    ${items}
    Should Be Equal As Numbers    ${count}    ${expected_count}

Add Product To Cart
    [Documentation]    Click the "Add to cart" button for a product by its name.
    [Arguments]    ${product_name}
    Click    css=.inventory_item:has-text("${product_name}") button[id^="add-to-cart"]

Remove Product From Cart
    [Documentation]    Click the "Remove" button for a product by its name.
    [Arguments]    ${product_name}
    Click    css=.inventory_item:has-text("${product_name}") button[id^="remove"]

Open Product Details
    [Documentation]    Click on a product name to open its detail page.
    [Arguments]    ${product_name}
    Click    css=.inventory_item_name:has-text("${product_name}")

Cart Badge Should Show
    [Documentation]    Verify the cart badge displays the expected item count.
    [Arguments]    ${expected_count}
    Get Text    ${CART_BADGE}    ==    ${expected_count}

Sort Products By
    [Documentation]    Select a sorting option from the dropdown.
    [Arguments]    ${sort_option}
    Select Options By    ${SORT_DROPDOWN}    value    ${sort_option}
