*** Settings ***
Resource        ../resources/main.robot
Test Setup      Open App
Test Teardown    Close App

*** Variables ***
${message}    ${login.message}

*** Test Cases ***
Verify if filling out the login form correctly must login to the app
    [Tags]    TS-001    login_successfully
    Given I fill out the login form fields    ${login.standard_user}    ${login.secret_sauce}
    Then I see the products list
    
Verify if filling out the login form with locked user should not login and show error message
    [Tags]    TS-002    login_locked_user
    Given I fill out the login form fields    ${login.locked_out_user}    ${login.secret_sauce}
    Then I should not login and see error message    ${message.locked_out_user}

Verify if filling out the login form with invalid username should not login and show error message
    [Tags]    TS-003    login_invalid_username
    Given I fill out the login form fields    ${login.invalid_standard_user}    ${login.secret_sauce}
    Then I should not login and see error message    ${message.invalid_credentials}

Verify if filling out the login form with invalid password should not login and show error message
    [Tags]    TS-004    login_invalid_password
    Given I fill out the login form fields    ${login.standard_user}    ${login.invalid_secret_sauce}
    Then I should not login and see error message    ${message.invalid_credentials}

Verify if not filling out the login form should not login and show error message
    [Tags]    TS-005    login_no_credentials
    Given I fill out the login form fields    ${EMPTY}    ${EMPTY}
    Then I should not login and see error message    ${message.username_required}

Verify if not filling out the login username field should not login and show error message
    [Tags]    TS-006    login_no_username
    Given I fill out the login form fields    ${EMPTY}    ${login.secret_sauce}
    Then I should not login and see error message    ${message.username_required}

Verify if not filling out the login password field should not login and show error message
    [Tags]    TS-007    login_no_password
    Given I fill out the login form fields    ${login.standard_user}    ${EMPTY}
    Then I should not login and see error message    ${message.password_required}

Verify if it is possible to logout
    [Tags]    TS-008    logout_successfully
    Given I fill out the login form fields    ${login.standard_user}    ${login.secret_sauce}
    When I see the products list
    Then I can logout and see login form