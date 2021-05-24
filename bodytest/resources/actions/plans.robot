*** Settings ***
Documentation    Ações da feature de gestão de planos

*** Variable ***
${TITLE_FIELD}      id=title
${DURATION_FIELD}   id=duration
${PRICE_FIELD}      css=input[name=price]
${TOTAL_FIELD}      css=input[name=total]

*** Keywords ***

## Forms
Submit Plan Form

    Click        xpath=//button[contains(text(), "Salvar")]

Fill Plan Form
    [Arguments]    ${plan}

    Fill Text    ${TITLE_FIELD}        ${plan.title}
    Fill Text    ${DURATION_FIELD}     ${plan.duration} 
    Fill Text    ${PRICE_FIELD}        ${plan.price} 


New Plan
    [Arguments]    ${plan}

    Fill Text    ${TITLE_FIELD}        ${plan.title}
    Fill Text    ${DURATION_FIELD}     ${plan.duration} 
    Fill Text    ${PRICE_FIELD}        ${plan.price} 
    
    Submit Plan Form

Update A Plan
    [Arguments]    ${plan}

    Fill Text    ${TITLE_FIELD}        ${plan['title']}
    Fill Text    ${DURATION_FIELD}     ${plan['duration']}
    Fill Text    ${PRICE_FIELD}        ${plan['price']}

    Submit Plan Form

Update A Plan Without Full Price
    [Arguments]    ${plan}

    Fill Text    ${TITLE_FIELD}        ${plan['title']}
    Fill Text    ${DURATION_FIELD}     ${plan['duration']}
    
    Submit Plan Form

## Links & Buttons
Go To Form Plan
    Click        css=a[href$="planos/new"]
    Wait For Elements State    css=h1 >> text=Novo plano    visible    5

Go to Plan Update Form
    [Arguments]    ${title}

    Click                      xpath=//td[contains(text(), "${title}")]/..//a[@class="edit"]
    Wait For Elements State    css=h1 >> text=Edição de plano    visible    5


## Valildations
Total Plan Should Be
    [Arguments]     ${total}

    Get Attribute       ${TOTAL_FIELD}      value    ==    ${total}   

Plan Name Should Not Visible
    [Arguments]    ${title}

    Wait For Elements State    xpath=//td[contains(text(), "${title}")]/../td//button[@id="trash"]    detached    5

Plan Name Should Be Visible
    [Arguments]    ${title}

    Wait For Elements State        css=table tbody tr >> text=${title}    visible    5