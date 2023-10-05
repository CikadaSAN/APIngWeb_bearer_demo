*** Settings ***
Library  Collections
Library  RequestsLibrary
Library  DateTime
Library  String

*** Keywords ***
Login User
    Create Session    api_test    ${testUrl}    verify=True
    &{headers}=     Create Dictionary   Content-Type=application/json
    Set Test Variable    ${data}    {"email":"${username}","password":"${userPassword}"}
    ${resp}=    POST Request    api_test    /login    data=${data}    headers=${headers}
    ${body}=    Set Variable    ${resp.json()}
    ${code}=    Get From Dictionary    ${body}    status
    Log To Console    API Login Response : ${body}
    Should Be Equal    ${code}    ${200}

    ${respEmail}=    set variable    ${body['result']['email']}
    should be equal    ${username}    ${respEmail}
    set global variable    ${userToken}    ${body['token']}

    Log To Console    === Hit API Login Success ! ===

Login User With New Password
    Create Session    api_test    ${testUrl}    verify=True
    &{headers}=     Create Dictionary   Content-Type=application/json
    Set Test Variable    ${data}    {"email":"${username}","password":"${userNewPassword}"}
    ${resp}=    POST Request    api_test    /login    data=${data}    headers=${headers}
    ${body}=    Set Variable    ${resp.json()}
    ${code}=    Get From Dictionary    ${body}    status
    Log To Console    API Login Response : ${body}
    Should Be Equal    ${code}    ${200}

    ${respEmail}=    set variable    ${body['result']['email']}
    should be equal    ${username}    ${respEmail}
    set global variable    ${userToken}    ${body['token']}

    Log To Console    === Hit API Login Success ! ===