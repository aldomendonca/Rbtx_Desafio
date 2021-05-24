*** Settings ***
Documentation    Cadastro de Planos
...              Lembrete: robot -d ./logs tests\plans/create.robot
...                        robot -d ./logs -i Teste tests\plans\create.robot

Resource        ${EXECDIR}/resources/base.robot

Suite Setup    Start Admin Session
Test Teardown  Thinking And Take Screenshot    2


*** Test Cases ***

Cenario: Calcular preço total do plano

    &{plan}     Create Dictionary       title=Papito Teste      duration=12     price=19,99     total=R$ 239,88
    
    Go To Plans
    Go To Form Plan
    Fill Plan Form           ${plan}
    Total Plan Should Be     ${plan.total}

Cenario: Cadastrar Novo Plano

    &{plan}     Create Dictionary       title=Plano 1      duration=3     price=200,00     total=R$ 600,00  
    
    Remove Plan By Name       ${plan.title}
    Go To Plans
    Go To Form Plan
    New Plan                  ${plan}
    Toaster Text Should Be    Plano cadastrado com sucesso

    [Teardown]                Thinking And Take Screenshot    2

Cenario: Desistir de Cadastrar

    &{plan}     Create Dictionary       title=Plano 1      duration=3     price=200,00     total=R$ 600,00
    
    Go To Plans
    Go To Form Plan
    Fill Plan Form           ${plan}
    To give up
    Page Plans

Cenario: Informar excesso de caracteres no campo Titulo do Plano
 
    &{plan}     Create Dictionary       title=Plano 1      duration=3     price=200,00     total=R$ 600,00

    Go To Plans
    Go To Form Plan
    ${plan.title}            Insert Too Many Characters   
    Fill Plan Form           ${plan}
    Submit Plan Form
    Toaster Text Should Be   Erro cadastrar aluno!

Cenario: Informar mais de 60 meses no campo Duração

    &{plan}     Create Dictionary       title=Plano 1      duration=61     price=200,00     total=R$ 600,00
    
    Go To Plans
    Go To Form Plan
    Fill Plan Form           ${plan}
    Submit Plan Form
    Alert Text Should Be     A duração dever ser no máximo 60 meses


Cenario: Informar 60 meses no campo Duração

    &{plan}     Create Dictionary       title=Plano 1      duration=60     price=200,00     total=R$ 12.000,00
    
    Remove Plan By Name      ${plan.title}
    Go To Plans
    Go To Form Plan
    Fill Plan Form           ${plan}
    Submit Plan Form
    Toaster Text Should Be   Plano cadastrado com sucesso
    Page Plans


Cenario: Informar 59 meses no campo Duração
 
    &{plan}     Create Dictionary       title=Plano 1      duration=59     price=200,00     total=R$ 11800,00
    
    Remove Plan By Name      ${plan.title}
    Go To Plans
    Go To Form Plan
    Fill Plan Form           ${plan}
    Submit Plan Form
    Toaster Text Should Be   Plano cadastrado com sucesso
    Page Plans


Cenario: Informar "0,00" no campo Preço Mensal

    &{plan}     Create Dictionary       title=Plano 1      duration=6     price=0,00     total=R$ 0,00
    
    Go To Plans
    Go To Form Plan
    Fill Plan Form           ${plan}
    Submit Plan Form
    Toaster Text Should Be   O valor do plano deve ser maior que zero!


Cenario: Informar valor acima do limite no campo Preço Mensal

    &{plan}     Create Dictionary       title=Plano 1      duration=6     price=500000000,00     total=R$ 3000000000,00
    
    Go To Plans
    Go To Form Plan
    Fill Plan Form           ${plan}
    Submit Plan Form
    Toaster Text Should Be   Erro cadastrar aluno!


Cenario: Campos obrigatórios

    @{expected_alerts}    Set Variable    Informe o título do plano    Informe a duração do plano em meses    O preço é obrigatório
    @{got_alerts}         Create List 

    Go To Plans
    Go To Form Plan
    Clear Text               ${PRICE_FIELD}
    Submit Plan Form

    FOR     ${index}     IN RANGE    1    4
        ${span}          Get Required Alerts    ${index}
        Append To List   ${got_alerts}          ${span}
    END 

    Log    ${expected_alerts}
    Log    ${got_alerts}

    Lists Should Be Equal    ${expected_alerts}    ${got_alerts}


Cenario: Plano Duplicado
    [Documentation]    Não deveria permitir. Reportar Bug.

    &{plan}     Create Dictionary       title=Plano 1      duration=3     price=200.00
    
    Insert Plan              ${plan}
    Go To Plans
    Go To Form Plan
    Fill Plan Form           ${plan}
    Submit Plan Form
    Toaster Text Should Be   Plano cadastrado com sucesso
    Page Plans
    Search By Name                     ${plan.title}
    Name or Title Should Be Visible    ${plan.title}
    Total Itens Should Be              2

