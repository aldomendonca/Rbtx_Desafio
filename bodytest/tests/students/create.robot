*** Settings ***
Documentation    Cadastro de Alunos

Resource    ${EXECDIR}/resources/base.robot
#${EXECDIR} -> É o diretório BODYTEST


Suite Setup    Start Admin Session
Test Teardown  Take Screenshot 


*** Test Cases ***
Cenario: Novo aluno
    
    &{student}    Create Dictionary    name=Fernando Papito    email=fernando@qaninja.academy    age=38    weight=92    feet_tall=1.70   
    
    Remove Student            fernando@qaninja.academy
    Go To Students
    Go To Form Student
    New Student               ${student}
    Toaster Text Should Be    Aluno cadastrado com sucesso.

    [Teardown]                Thinking And Take Screenshot    2

Cenario: Não deve permitir email duplicado

    &{student}    Create Dictionary    name=João Henrique    email=joao@gmail.com    age=20    weight=70    feet_tall=1.70   
    
    Insert Student            ${student}
    Go To Students
    Go To Form Student
    New Student               ${student}
    Toaster Text Should Be    Email já existe no sistema.

    [Teardown]                Thinking And Take Screenshot    2

Cenario: Todos os campos devem ser obrigatórios

    @{expected_alerts}    Set Variable    Nome é obrigatório    O e-mail é obrigatório    idade é obrigatória    o peso é obrigatório    a Altura é obrigatória
    @{got_alerts}         Create List 

    Go To Students
    Go To Form Student
    Submit Student Form

    #Essa estratégia interrompe a execução se um dos elementos for diferente do esperado na lista
    # FOR      ${alerts}    IN     @{expected_alerts}
    #     Alert Text Should Be    ${alerts}
    # END  

    #Essa estratégia compara as duas listas (a esperada e a encontrada) compara e aponta a diferença entre elas
    #Para testar, troque "idade é obrigatória" para "idade é requerida"
    FOR     ${index}     IN RANGE    1    6
        ${span}          Get Required Alerts    ${index}
        Append To List   ${got_alerts}          ${span}
    END 

    Log    ${expected_alerts}
    Log    ${got_alerts}

    Lists Should Be Equal    ${expected_alerts}    ${got_alerts}

#Forma 1

    # Check Age Numeric Field
    #     [Tags]    temp

    #     Go To Students
    #     Go To Form Student
    #     Field Should Be Number    css=input[name=age]


    # Check Weight Numeric Field
    #     [Tags]    temp

    #     Go To Students
    #     Go To Form Student
    #     Field Should Be Number    css=input[name=weight]

    # Check Feet Tall Numeric Field
    #     [Tags]    temp

    #     Go To Students
    #     Go To Form Student
    #     Field Should Be Number    css=input[name=feet_tall]

#Forma 2
Cenario: Validação dos campos numéricos
    [Tags]        temp
    [Template]    Check Type Field On Student Form
    ${AGE_FIELD}            number
    ${WEIGHT_FIELD}         number
    ${FEET_TALL_FIELD}      number

Cenario: Validar campo do tipo email
    [Tags]        temp
    [Template]    Check Type Field On Student Form
    ${EMAIL_FIELD}         email

Cenario: Menor de 14 anos não pode fazer cadastro 
    
    &{student}    Create Dictionary    name=Livia da Silva    email=livia@yahoo.com    age=13    weight=50    feet_tall=1.65
    
    Go To Students
    Go To Form Student
    New Student    ${student}
    Alert Text Should Be    A idade deve ser maior ou igual 14 anos

*** Keywords ***

Check Type Field On Student Form
    #Essa keyword representa um comportamento específico
    #Não é um app action
    #Não é um caso de teste
    #É como se fosse um shared step
    #É um template de comportamento
    #Faz parte da suíte
    [Arguments]    ${element}    ${type}
    Go To Students
    Go To Form Student
    Field Should Be Type    ${element}    ${type}
    