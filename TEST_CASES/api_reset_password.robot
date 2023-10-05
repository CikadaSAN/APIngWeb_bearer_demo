*** Settings ***
Library  Collections
Library  RequestsLibrary
Library  DateTime
Library  String

*** Keywords ***
Reset User Password
    Create Session    api_test    ${testUrl}    verify=True
    &{headers}=     Create Dictionary   Content-Type=application/json
    Set Test Variable    ${data}    {"password":"${userNewPassword}","password_confirmation":"${userNewPassword}","email":"${username}","token":"${forgotToken}"}
    ${resp}=    POST Request    api_test    /reset-password    data=${data}    headers=${headers}
    ${body}=    Set Variable    ${resp.json()}
    ${code}=    Get From Dictionary    ${body}    status
    Log To Console    API Reset Password Response : ${body}
    Should Be Equal    ${code}    ${200}
    Log To Console    === Hit API Forgot Password Success ! ===