*** Settings ***
Documentation    Buscar Planos

Resource    ${EXECDIR}/resources/base.robot

Suite Setup    Start Admin Session
Test Teardown  Thinking And Take Screenshot    2


*** Test Cases ***

Cenario: Busca Exata

    &{plan}     Create Dictionary    title=Plano 1      duration=3     price=200.00 
    
    Remove Plan By Name            ${plan.title}
    Insert Plan                    ${plan}
    Go To Plans
    Search By Name                 ${plan.title}
    Plan Name Should Be Visible    ${Plan.title}
    Total Itens Should Be          1

Cenario: Registro não encontrado

    ${plan}    Set Variable        Plano X
    
    Remove Plan By Name            ${plan}
    Go To Plans
    Search By Name                 ${plan}
    Register Should Not Be Found

Cenario: Busca planos por um único termo 
    [Tags]   Teste

    ${fixture}     Get JSON        plans-search.json
    ${plans}       Set Variable    ${fixture['plans']}
    ${word}        Set Variable    ${fixture['word']}
    ${total}       Set Variable    ${fixture['total']}
 
    Remove Plan By Name     ${word}
    
    FOR     ${item}    IN   @{plans}
        Insert Plan         ${item}
    END   

    Go To Plans
    Search By Name     ${word}

    FOR     ${item}    IN   @{plans}
        Plan Name Should Be Visible    ${item['title']}
    END

    Total Itens Should Be   ${total}
