*** Settings ***
Documentation    Ações de componentes genéricos

*** Keywords ***
## Validations
Toaster Text Should Be
    [Arguments]    ${expect_text}
    
    Wait For Elements State    css=.Toastify__toast-body >> text=${expect_text}    visible    5

Alert Text Should Be
    [Arguments]    ${expect_text}
    Wait For Elements State    css=form span >> text=${expect_text}    visible    5

Field Should Be Type
    [Arguments]    ${element}    ${type}

    ${attr}    Get Attribute    ${element}    type
    Should Be Equal    ${attr}    ${type}

Register Should Not Be Found
    Wait For Elements State           css=div >> text=Nenhum registro encontrado.    visible    5
    Wait For Elements State           css=table        detached        5

Total Itens Should Be
    [Arguments]    ${number}

    ${element}     Set Variable   css=#pagination .total 

    Wait For Elements State        ${element}               visible    5
    Get Text                       ${element}    ==         Total: ${number}

Name or Title Should Be Visible
    [Documentation]    Papito, essa keyword serveria para Student e Plan,
    ...                mas não refatorei a "Students" para contemplar essa nova keyword.
    [Arguments]    ${name_title}

    Wait For Elements State        css=table tbody tr >> text=${name_title}    visible    5


## Return Elements & Texts
Get Required Alerts
    [Arguments]    ${index}

    ${span}    Get Text    xpath=(//form//span)[${index}]

    [return]    ${span}


Insert Too Many Characters
    ${variavel}    Replace Variables    11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111264
    [Return]    ${variavel} 
    

## Links & Buttons
Confirm Removal
    Click            text=SIM, pode apagar!

Cancel Removal
    Click            text=NÃO

To give up
    Click            text=Voltar

Request Removal
    [Documentation]    Papito, essa keyword serveria para Student e Plan,
    ...                mas não refatorei a "Students" para contemplar essa nova keyword.
#Representa uma solicitação de exlusão, porque somente vai excluir mesmo se clicar no botão "SIM, pode apagar"
    [Arguments]      ${variavel}
    Click            xpath=//td[contains(text(), "${variavel}")]/../td//button[@id="trash"]


## Forms
Search By Name
    [Documentation]    Papito, essa keyword serveria para Student e Plan,
    ...                mas não refatorei a "Students" para contemplar essa nova keyword.
    [Arguments]    ${name}    

    Fill Text        css=input[placeholder="Buscar plano"]    ${name}