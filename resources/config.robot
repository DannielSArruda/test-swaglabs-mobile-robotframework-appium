*** Settings ***
Resource    main.robot


*** Variables ***
${APP_NAME}                           sauce_labs.2.7.1.apk
${APP}                                ${CURDIR}/app/${APP_NAME}
${TIMEOUT}                            5

###Criar as variáveis abaixo com os valores dos dados de acesso ao Browserstack no arquivo variables.robot (mencionado abaixo).
${URL}                                http://127.0.0.1:4723/wd/hub
${PACKAGE}                            com.swaglabsmobileapp
${MAIN}                               com.swaglabsmobileapp.MainActivity
${PLATFORM_NAME}                      Android
${AUTOMATION_NAME}                    UIAutomator2
${PLATFORM_VERSION}                   %{PLATFORM_VERSION=13.0}
${PREFIXO_QA}                         com.swaglabsmobileapp:id

*** Keywords ***
Open App
    open application    ${URL}
    ...    automationName=${AUTOMATION_NAME}
    ...    platformName=${PLATFORM_NAME}
    ...    platformVersion=${PLATFORM_VERSION}
    ...    app=${APP}
    ...    appPackage=${PACKAGE}
    ...    appActivity=${MAIN}
    ...    disableWindowAnimation=true
    ...    autoGrantPermissions=true
    ...    appWaitPackage=${PACKAGE}
    Set Appium Timeout    ${TIMEOUT}

Close App
    Run Keyword And Ignore Error    Capture Page Screenshot
    Close All Applications