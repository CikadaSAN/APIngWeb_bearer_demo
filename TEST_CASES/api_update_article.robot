*** Settings ***
Library  Collections
Library  RequestsLibrary
Library  DateTime
Library  String

*** Keywords ***
Update Article
    Create Session    api_test    ${testUrl}    verify=True
    &{headers}=     Create Dictionary   Content-Type=application/json    Authorization=Bearer ${userToken}
    set global variable  ${updateTitle}    ${createTitle} Edited
    set global variable  ${updateBody}    ${createBody} Edited
    Set Test Variable    ${data}    {"title":"${updateTitle}","body":"${updateBody}","picture":"${picture}"}
    ${resp}=    PUT Request    api_test    /article/edit/${articleId}    data=${data}    headers=${headers}
    ${body}=    Set Variable    ${resp.json()}
    ${code}=    Get From Dictionary    ${body}    status
    Log To Console    API Update Article Response : ${body}

    Should Be Equal    ${code}    ${200}
    Log To Console    === Hit API Update Article Success ! ===