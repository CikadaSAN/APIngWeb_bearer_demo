*** Settings ***
Library  Collections
Library  RequestsLibrary
Library  DateTime
Library  String

*** Keywords ***
Delete Article
    Create Session    api_test    ${testUrl}    verify=True
    &{headers}=     Create Dictionary   Content-Type=application/json    Authorization=Bearer ${userToken}
    ${resp}=    DELETE Request    api_test    /article/delete/${articleId}    headers=${headers}
    ${body}=    Set Variable    ${resp.json()}
    ${code}=    Get From Dictionary    ${body}    status
    Log To Console    API Delete Article Response : ${body}

    Should Be Equal    ${code}    ${200}
    Log To Console    === Hit API Delete Article Success ! ===