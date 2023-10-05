*** Settings ***
Library  Collections
Library  RequestsLibrary
Library  DateTime
Library  String

*** Keywords ***
Create Article
    Create Session    api_test    ${testUrl}    verify=True
    &{headers}=     Create Dictionary   Content-Type=application/json    Authorization=Bearer ${userToken}
    set global variable  ${createTitle}    title ${randomAbc}
    set global variable  ${createBody}    body ${randomAbc}
    Set Test Variable    ${data}    {"title":"${createTitle}","body":"${createBody}","picture":"${picture}"}
    ${resp}=    POST Request    api_test    /article/create    data=${data}    headers=${headers}
    ${body}=    Set Variable    ${resp.json()}
    ${code}=    Get From Dictionary    ${body}    status
    Log To Console    API Create Article Response : ${body}

    Should Be Equal    ${code}    ${200}
    Log To Console    === Hit API Create Article Success ! ===