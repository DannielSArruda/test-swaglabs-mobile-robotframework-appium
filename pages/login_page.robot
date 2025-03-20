*** Settings ***
Resource    ../resources/main.robot

*** Variables ***
${USERNAME_FIELD}         xpath=//android.widget.EditText[@content-desc="test-Username"]
${PASSWORD_FIELD}         xpath=//android.widget.EditText[@content-desc="test-Password"]
${LOGIN_BUTTON}           xpath=//android.view.ViewGroup[@content-desc="test-LOGIN"]
${PRODUCT_LIST}           xpath=//android.widget.ScrollView[@content-desc="test-PRODUCTS"]
${ERROR_WARNING}          xpath=//android.view.ViewGroup[@content-desc="test-Error message"]
${MENU_BUTTON}            xpath=//android.view.ViewGroup[@content-desc="test-Menu"]
${LOGOUT_BUTTON}          xpath=//android.view.ViewGroup[@content-desc="test-LOGOUT"]

*** Keywords ***
I fill out the login form fields
    [Arguments]          ${username}          ${password}
    Fill in field        ${USERNAME_FIELD}    ${username}
    Fill in field        ${PASSWORD_FIELD}    ${password}
    Click on button      ${LOGIN_BUTTON}

I see the products list
    Wait and check if element is visible    ${PRODUCT_LIST}

I should not login and see error message
    [Arguments]          ${text}
    Wait and check if element is visible    ${ERROR_WARNING}
    Wait and check if text is visible       ${text}

I can logout and see login form
    Click on button      ${MENU_BUTTON}
    Click on button      ${LOGOUT_BUTTON}
    Wait and check if element is visible    ${LOGIN_BUTTON}