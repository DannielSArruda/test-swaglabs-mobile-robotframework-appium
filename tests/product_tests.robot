*** Settings ***
Resource        ../resources/main.robot
Test Setup      Open App
Test Teardown    Close App

*** Variables ***
${message}    ${products.message}

*** Test Cases ***
Verify if it is possible to add a product to cart
    [Tags]    TS-001    add_and_remove_product_from_cart
    Given I am logged and see product list    ${login.standard_user}    ${login.secret_sauce}
    When I add a product to cart              ${products.sauce_labs_bike_light}
    Then I remove the product from cart

Verify if updates the number of itens in cart as they are added
    [Tags]    TS-002    add_and_remove_all_products_from_cart
    Given I am logged and see product list    ${login.standard_user}    ${login.secret_sauce}
    When I add all products to cart
    Then I open cart and remove the products

Verify if it is possible to see product details and purchase it
    [Tags]    TS-003    see_and_purchase_product
    Given I am logged and see product list    ${login.standard_user}    ${login.secret_sauce}
    When I open a product to see its details    ${products.sauce_labs_bike_light}
    Then I add the product to cart and purchase it