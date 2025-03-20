*** Settings ***
Resource    main.robot

*** Keywords ***
Fill in field
    [Arguments]    ${field}    ${text}
    Wait and check if element is visible    ${field}
    Input Text        ${field}      ${text}

Click on button
    [Arguments]    ${element}
    Wait and check if element is visible    ${element}
    Click Element    ${element}

Wait and check if element is visible
    [Arguments]    ${element}    ${timeout}=${TIMEOUT}
    Wait Until Page Contains Element    ${element}     ${timeout}
    Element Should Be Visible    ${element}

Wait and check if element is not visible
    [Arguments]    ${element}    ${timeout}=${TIMEOUT}
    Wait Until Page Does Not Contain Element    ${element}     ${timeout}
    Page Should Not Contain Element    ${element}

Wait and check if text is visible
    [Arguments]    ${text}    ${timeout}=${TIMEOUT}
    Wait Until Page Contains    ${text}    ${timeout}
    Text Should Be Visible    ${text}

Swipe Until Element Is Visible
    [Arguments]    ${start_x}    ${start_y}    ${end_x}    ${end_y}    ${element}    ${click}=no
    FOR    ${INDEX}    IN RANGE    1    21
        Sleep    1s
        ${STATUS}=    Run Keyword And Return Status    Element Should Be Visible    ${element}
        IF    ${STATUS}
            Run Keyword If    '${click}' == 'yes'    Click Element    ${element}
            RETURN
        ELSE
            Swipe By Percent    ${start_x}    ${start_y}    ${end_x}    ${end_y}
        END
        IF    ${INDEX} == 20
            Fail    Element ${element} not found.
        END
    END

