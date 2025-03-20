*** Settings ***
Resource    ../resources/main.robot

*** Variables ***
${ADD_TO_CART_BUTTON}                   android.view.ViewGroup[contains(@content-desc, "test-ADD TO CART")]
${CART_BUTTON}                          xpath=//android.view.ViewGroup[@content-desc="test-Cart"]
${REMOVE_BUTTON}                        android.view.ViewGroup[contains(@content-desc, "test-REMOVE")]
${CART_LIST}                            xpath=//android.widget.ScrollView[@content-desc="test-Cart Content"]
${PRODUCT_DESCRIPTION}                  android.view.ViewGroup[contains(@content-desc, "test-Description")]
${PRODUCT_PRICE}                        android.view.ViewGroup[contains(@content-desc, "test-Price")]
${PRODUCT_IMAGE}                        xpath=//android.view.ViewGroup[@content-desc="test-Image Container"]/android.widget.ImageView
${CHECKOUT_BUTTON}                      xpath=//android.view.ViewGroup[@content-desc="test-CHECKOUT"]
${FIRST_NAME_FIELD}                     xpath=//android.widget.EditText[@content-desc="test-First Name"]
${LAST_NAME_FIELD}                      xpath=//android.widget.EditText[@content-desc="test-Last Name"]
${ZIP_CODE_FIELD}                       xpath=//android.widget.EditText[@content-desc="test-Zip/Postal Code"]
${CONTINUE_BUTTON}                      xpath=//android.view.ViewGroup[@content-desc="test-CONTINUE"]
${FINISH_BUTTON}                        xpath=//android.view.ViewGroup[@content-desc="test-FINISH"]
${COMPLETED_CHECKOUT_SCREEN}            xpath=//android.widget.ScrollView[@content-desc="test-CHECKOUT: COMPLETE!"]

*** Keywords ***
I am logged and see product list
    [Arguments]          ${username}          ${password}
    I fill out the login form fields    ${username}          ${password}
    I see the products list

I add a product to cart
    [Arguments]        ${product}
    Click on button    xpath=//android.widget.TextView[contains(@text, "${product.name}")]//following-sibling::${ADD_TO_CART_BUTTON}
    Wait and check if element is visible      ${CART_BUTTON}/android.view.ViewGroup/android.widget.TextView
    Element Text Should Be                    ${CART_BUTTON}/android.view.ViewGroup/android.widget.TextView    1

I remove the product from cart
    Click on button    xpath=//${REMOVE_BUTTON}
    Wait and check if element is not visible    ${CART_BUTTON}/android.view.ViewGroup/android.widget.TextView

I add all products to cart
    FOR    ${index}    ${product}    IN ENUMERATE    @{products.all_products}
        Swipe Until Element Is Visible    50    75    50    50      xpath=//android.widget.TextView[contains(@text, "${product}")]//following-sibling::${ADD_TO_CART_BUTTON}    yes
        ${adjusted_index}=    Evaluate    ${index} + 1
        ${adjusted_index_string}=    Convert To String    ${adjusted_index}
        Wait and check if element is visible                        ${CART_BUTTON}/android.view.ViewGroup/android.widget.TextView
        Element Text Should Be                                      ${CART_BUTTON}/android.view.ViewGroup/android.widget.TextView    ${adjusted_index_string}
        
    END
    Set Test Variable    ${adjusted_index}

I open cart and remove the products
    Click on button    ${CART_BUTTON}
    Wait and check if element is visible    ${CART_LIST}

    FOR    ${index}    ${product}    IN ENUMERATE    @{products.all_products}
        Swipe Until Element Is Visible    50    75    50    50      xpath=//android.widget.TextView[contains(@text, "${product}")]//ancestor::${PRODUCT_DESCRIPTION}//following-sibling::${PRODUCT_PRICE}//child::${REMOVE_BUTTON}   yes


        ${adjusted_index}=    Evaluate    ${adjusted_index} - 1
        
        IF    ${adjusted_index} != 0
            ${adjusted_index_string}=    Convert To String    ${adjusted_index}
            Wait and check if element is visible                        ${CART_BUTTON}/android.view.ViewGroup/android.widget.TextView
            Element Text Should Be                                      ${CART_BUTTON}/android.view.ViewGroup/android.widget.TextView    ${adjusted_index_string}
        END

    END
    Wait and check if element is not visible    ${CART_BUTTON}/android.view.ViewGroup/android.widget.TextView

I open a product to see its details
    [Arguments]        ${product}
    Click on button    xpath=//android.widget.TextView[contains(@text, "${product.name}")]
    Wait and check if element is visible    ${PRODUCT_IMAGE}
    Wait and check if text is visible    ${product.name}
    Wait and check if text is visible    ${product.description}
    Swipe Until Element Is Visible    50    75    50    50    xpath=//${ADD_TO_CART_BUTTON}
    Wait and check if text is visible    ${product.price}

I add the product to cart and purchase it
    Click on button    xpath=//${ADD_TO_CART_BUTTON}
    Wait and check if element is visible      ${CART_BUTTON}/android.view.ViewGroup/android.widget.TextView
    Element Text Should Be                    ${CART_BUTTON}/android.view.ViewGroup/android.widget.TextView    1
    Click on button    ${CART_BUTTON}
    Click on button    ${CHECKOUT_BUTTON}
    Fill in field    ${FIRST_NAME_FIELD}    dwanye
    Fill in field    ${LAST_NAME_FIELD}    silv
    Fill in field    ${ZIP_CODE_FIELD}    69087655
    Click on button    ${CONTINUE_BUTTON}
    Swipe Until Element Is Visible    50    75    50    50    ${FINISH_BUTTON}    yes
    Wait and check if element is visible    ${COMPLETED_CHECKOUT_SCREEN}
    Wait and check if text is visible       ${message.your_order}