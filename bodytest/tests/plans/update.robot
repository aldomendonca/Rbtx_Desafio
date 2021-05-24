*** Settings ***
Documentation    Atualizar Planos

Resource        ${EXECDIR}/resources/base.robot

Test Setup     Start Admin Session    200ms
Test Teardown  Thinking And Take Screenshot    2


*** Test Cases ***

Cenario: Atualizar um plano já cadastrado

    ${fixture}          Get JSON        plans-update.json

    ${PlanoEspecial}    Set Variable    ${fixture['before']}
    ${PlanoNatal}       Set Variable    ${fixture['after']}

    Remove Plan By Name        ${PlanoEspecial['title']}
    Remove Plan By Name        ${PlanoNatal['title']}
    Insert Plan                ${PlanoEspecial}
    Go To Plans
    Search By Name             ${PlanoEspecial['title']}
    Go to Plan Update Form     ${PlanoEspecial['title']}
    #Papito: Foi necessário incluir parâmetro de slowmotion de 200ms lá na "Start Admin Session" por causa desse teste,
    #        porque na velocidade normal o form de preço não reconhece o valor inserido (assume o valor que tinha antes).
    #        Mas não houve impacto nos outros testes porque deixei o parâmetro opcional e default 1ms.
    Update A Plan              ${PlanoNatal}
    Toaster Text Should Be     Plano Atualizado com sucesso

    [Teardown]                 Thinking And Take Screenshot    2


Cenario: Desistir de Atualizar

    ${fixture}          Get JSON        plans-update.json

    ${PlanoEspecial}    Set Variable    ${fixture['before']}
    ${PlanoNatal}       Set Variable    ${fixture['after']}

    Remove Plan By Name        ${PlanoEspecial['title']}
    Remove Plan By Name        ${PlanoNatal['title']}
    Insert Plan                ${PlanoEspecial}
    Go To Plans
    Search By Name             ${PlanoEspecial['title']}
    Go to Plan Update Form     ${PlanoEspecial['title']}
    To give up
    Page Plans

Cenario: Atualizar sem alterar o preço Mensal
    [Documentation]   Se não alterar o campo "Preço Mensal" o Valor Total fica zerado. Reportar Bug
    ...               Papito, às vezes a validação de preço não funciona. Não é a primeira vez que ocorre.
    ...               O Robot acusa "Attribute css=input[name=total] 'R$ 0,00' (str) should be 'R$ 0,00' (str)"
    ...               Tentei de tudo que sabia então acredito ser um bug do Robot, e o pior, intermitente.
    ...               Porém uma vez que funciona certinho não volta a acontecer.

    ${fixture}          Get JSON        plans-update-partial.json

    ${PlanoQuad}        Set Variable    ${fixture['before']}
    ${PlanoOcto}        Set Variable    ${fixture['after']}

    Remove Plan By Name                 ${PlanoQuad['title']}
    Remove Plan By Name                 ${PlanoOcto['title']}
    Insert Plan                         ${PlanoQuad}
    Go To Plans
    Search By Name                      ${PlanoQuad['title']}
    Go to Plan Update Form              ${PlanoQuad['title']}
    Update A Plan Without Full Price    ${PlanoOcto}
    Toaster Text Should Be              Plano Atualizado com sucesso
    Total Plan Should Be                R$ 400,00

    [Teardown]                          Thinking And Take Screenshot    2