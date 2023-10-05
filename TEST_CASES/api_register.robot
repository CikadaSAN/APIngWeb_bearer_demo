*** Settings ***
Library  Collections
Library  RequestsLibrary
Library  DateTime
Library  String

*** Keywords ***
Register User
    Create Session    api_test    ${testUrl}    verify=True
    ${randomAbc}=    generate random string    4    [LETTERS]
    set global variable    ${randomAbc}
    ${randomNum}=    generate random string    8    [NUMBERS]
    set global variable    ${randomNum}

    &{headers}=     Create Dictionary   Content-Type=application/json
    Set Test Variable    ${data}    {"name":"User ${randomAbc}","email":"test${randomAbc}@ciko.com","phone":"08${randomNum}","password":"${userPassword}","password_confirmation":"${userPassword}"}
    ${resp}=    POST Request    api_test    /register    data=${data}    headers=${headers}
    ${body}=    Set Variable    ${resp.json()}
    ${code}=    Get From Dictionary    ${body}    status
    Log To Console    API Register Response : ${body}
    Should Be Equal    ${code}    ${200}

    set global variable    ${username}    test${randomAbc}@ciko.com
    set global variable    ${userFullName}    User ${randomAbc}
    set global variable    ${userPhone}    08${randomNum}

    Log To Console    Name : ${userFullName} | Email : ${username} | Password : ${userPassword} | Phone : ${userPhone}
    Log To Console    === Hit API Register Success ! ===