*** Settings ***
Library  Collections
Library  RequestsLibrary
Library  DateTime
Library  String

*** Keywords ***
Get All Article
    Create Session    api_test    ${testUrl}    verify=True
    &{headers}=     Create Dictionary   Content-Type=application/json    Authorization=Bearer ${userToken}
    ${resp}=    GET Request    api_test    /articles    headers=${headers}
    ${body}=    Set Variable    ${resp.json()}
    ${code}=    Get From Dictionary    ${body}    status
    Log To Console    API Get All Article Response : ${body}
    Should Be Equal    ${code}    ${200}

    Log To Console    === Hit API Get All Article Success ! ===

Get Single Article
    Create Session    api_test    ${testUrl}    verify=True
    &{headers}=     Create Dictionary   Content-Type=application/json    Authorization=Bearer ${userToken}
    ${resp}=    GET Request    api_test    /article/1    headers=${headers}
    ${body}=    Set Variable    ${resp.json()}
    ${code}=    Get From Dictionary    ${body}    status
    Log To Console    API Get Single Article Response : ${body}
    Should Be Equal    ${code}    ${200}

Get Article ID from User Article
    Create Session    api_test    ${testUrl}    verify=True
    &{headers}=     Create Dictionary   Content-Type=application/json    Authorization=Bearer ${userToken}
    ${resp}=    GET Request    api_test    /articles    headers=${headers}
    ${body}=    Set Variable    ${resp.json()}
    ${code}=    Get From Dictionary    ${body}    status
    Should Be Equal    ${code}    ${200}

    ${articleList}=    Get From Dictionary    ${body}    result
    reverse list    ${articleList}
    FOR    ${item}    IN    @{articleList}
        ${curTitle}=    Set variable    ${item['title']}
        IF    "${curTitle}" == "${createTitle}"
            ${articleId}=    Set variable    ${item['id']}
            set global variable    ${articleId}
            ${curBody}=    Set variable    ${item['body']}
            ${curPic}=    Set variable    ${item['picture']}
            ${curUserId}=    Set Variable    ${item['user_id']}
            should be equal    ${curBody}    ${createBody}
            should be equal    ${curTitle}    ${createTitle}
            Log To Console    Article ID : ${articleId} | Article Title : ${createTitle} |Body : ${curBody} | Pictures : ${curPic} | Created By User ID : ${curUserId}
            exit for loop
        END
    END
    Log To Console    === Hit API Get All Article Success ! ===

#    ${articleList}       Get From Dictionary     ${body}    result
#    ${count}=    get length    ${articleList}
#    ${index}=    set variable    0
#    FOR    ${index}    IN RANGE    ${count}
#        ${curTitle}=    Set variable    ${resp.json()['result'][${index}]['title']}
#        IF    "${curTitle}" == "${createTitle}"
#            ${id}=    set variable    ${resp.json()['result'][${index}]['id']}
#            Set Global Variable    ${id}
#            Log To Console    Article ID : ${id} | Article Title : ${curTItle}
#            exit for loop
#        END
#    END

Get Article After Update
    Create Session    api_test    ${testUrl}    verify=True
    &{headers}=     Create Dictionary   Content-Type=application/json    Authorization=Bearer ${userToken}
    ${resp}=    GET Request    api_test    /article/${articleId}    headers=${headers}
    ${body}=    Set Variable    ${resp.json()}
    ${code}=    Get From Dictionary    ${body}    status
    Log To Console    API Get Single Article Response : ${body}
    Should Be Equal    ${code}    ${200}