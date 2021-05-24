*** Settings ***
Documentation    Ações de autenticação


*** Keywords ***
Go To Login Page
    Go To    https://bodytest-web-aldo.herokuapp.com/    timeout=60s    

Login With
    [Arguments]   ${email}    ${pass}
    
    Fill Text     css=input[name=email]       ${email}
    Fill Text     css=input[name=password]    ${pass}
    Click         text=Entrar 
