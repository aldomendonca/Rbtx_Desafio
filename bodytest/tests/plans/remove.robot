*** Settings ***
Documentation    Remover Planos

Resource        ${EXECDIR}/resources/base.robot

Test Setup      Start Admin Session
Test Teardown   Thinking And Take Screenshot    2


*** Test Cases ***
Cenario: Remover aluno cadastrado

    &{plan}     Create Dictionary    title=Plano 1      duration=3     price=200.00

    Insert Plan                      ${plan}
    Go To Plans
    Search By Name                   ${plan.title}
    Request Removal                  ${plan.title}
    Confirm Removal
    Toaster Text Should Be           Plano removido com sucesso
    Plan Name Should Not Visible     ${plan.title}

     
Cenario: Desistir da exclusão

    &{plan}     Create Dictionary    title=Plano 1      duration=3     price=200.00
    
    Insert Plan                      ${plan}
    Go To Plans
    Search By Name                   ${plan.title}
    Request Removal                  ${plan.title}
    Cancel Removal
    Plan Name Should Be Visible      ${plan.title}


Cenario: Desistir da exclusão clicando ESC

    &{plan}     Create Dictionary    title=Plano 1      duration=3     price=200.00
    
    Insert Plan                      ${plan}
    Go To Plans
    Search By Name                   ${plan.title}
    Request Removal                  ${plan.title}
    Wait For Elements State          css=[role="dialog"]    visible
    Keyboard Key                     press    Escape
    Wait For Elements State          css=[role="dialog"]    hidden
    Plan Name Should Be Visible      ${plan.title}


Cenario: Desistir da exclusão clicando ENTER

    &{plan}     Create Dictionary    title=Plano 1      duration=3     price=200.00
    
    Insert Plan                      ${plan}
    Go To Plans
    Search By Name                   ${plan.title}
    Request Removal                  ${plan.title}
    Wait For Elements State          css=[role="dialog"]    visible
    Keyboard Key                     press    Enter
    Wait For Elements State          css=[role="dialog"]    hidden
    Plan Name Should Be Visible      ${plan.title}


