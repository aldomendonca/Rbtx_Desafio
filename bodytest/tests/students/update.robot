*** Settings ***
Documentation    Atualizar Alunos

Resource    ${EXECDIR}/resources/base.robot
#${EXECDIR} -> É o diretório BODYTEST


Suite Setup    Start Admin Session
Test Teardown  Take Screenshot 


*** Test Cases ***

Cenario: Atualizar um aluno já cadastrado

    ${fixture}       Get JSON        students-update.json

    ${kamalakhan}    Set Variable    ${fixture['before']}
    ${msmarvel}      Set Variable    ${fixture['after']}

    Remove Student By Name        ${kamalakhan['name']}
    Remove Student By Name        ${msmarvel['name']}

    Insert student                ${kamalakhan}
    Go To Students
    Search Student By Name        ${kamalakhan['name']}
    Go to Student Update Form     ${kamalakhan['email']}
    Update A Student              ${msmarvel}
    Toaster Text Should Be        Aluno atualizado com sucesso.

    [Teardown]                    Thinking And Take Screenshot    2



