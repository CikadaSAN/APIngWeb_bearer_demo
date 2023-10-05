*** Settings ***
Library  Collections
Library  RequestsLibrary
Library  DateTime
Library  String

*** Keywords ***
Forgot User Password
    Create Session    api_test    ${testUrl}    verify=True
    &{headers}=     Create Dictionary   Content-Type=application/json
    Set Test Variable    ${data}    {"email":"${username}","title":"Forgot Password ${userFullName}","link":"https://example.com?token=${userToken}"}
    ${resp}=    POST Request    api_test    /forgot-password    data=${data}    headers=${headers}
    ${body}=    Set Variable    ${resp.json()}
    ${code}=    Get From Dictionary    ${body}    status
    Log To Console    API Forgot Password Response : ${body}
    Should Be Equal    ${code}    ${200}
    should not be empty    ${body['or_use_this_token']}
    set global variable    ${forgotToken}    ${body['or_use_this_token']}

    Log To Console    User Email : ${username} | Forgot Password Token : ${forgotToken}
    Log To Console    === Hit API Forgot Password Success ! ===