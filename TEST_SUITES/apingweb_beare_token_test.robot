*** Settings ***
Library  Collections
Library  RequestsLibrary

# Test Cases
Resource    ../TEST_CASES/api_register.robot
Resource    ../TEST_CASES/api_login.robot
Resource    ../TEST_CASES/api_forgot_password.robot
Resource    ../TEST_CASES/api_reset_password.robot
Resource    ../TEST_CASES/api_get_article.robot
Resource    ../TEST_CASES/api_create_article.robot
Resource    ../TEST_CASES/api_update_article.robot
Resource    ../TEST_CASES/api_delete_article.robot


# Variable
Resource    ../VARIABLES/test_variables.robot

*** Test Cases ***
Register User to APIngWeb
    Register User

Login User to APIngWeb
    Login User

Ensure User should be able to forgot password
    Forgot User Password
    Reset User Password

Ensure user should be able to login with new password
    Login User With New Password

Ensure user should be able to get all article
    Get All Article

Ensure user should be able to get single article
    Get Single Article

Ensure user should be able to create new article
    Create Article
    Get Article ID from User Article

Ensure user should be able to update existing article
    Update Article
    Get Article After Update

Ensure user should be able to delete article
    Delete Article

