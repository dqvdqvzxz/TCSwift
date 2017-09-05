//
//  TRCAPIKeyContant.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 6/26/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

// ******************** API ROOT ******************************************

// ******************** LOCAL
#if ENV_1
let ROOT_URL =                      "http://172.16.210.122/"
    
//********************* DEV ENV OF CUSTOMER
#elseif ENV_2
let ROOT_URL =                      "http://42.125.230.115/"

//********************* RELEASE
#elseif ENV_0
let ROOT_URL =                      "http://172.16.210.122/"
#endif

let APP_DOMAIN =                    "\(ROOT_URL)api/v1/"
let APP_RULE =                      "\(ROOT_URL)rule"
let APP_POLICY =                    "\(ROOT_URL)privacy_policy"
let APP_FAQ_LIST =                  "\(ROOT_URL)faq_list"
let APP_FAQ_DETAIL =                "\(ROOT_URL)faq_detail/1"

// *************************************************************************

//MARK: API
let HEADER_AUTHORIZATION =          "Basic dG9yaV9hcHBfaW9zX3Rlc3Q6MmY1YzY5Njc4Mzg4NGIwMmEwNjkxNjNlOWI2ODAzMTI="
let HEADER_CONTENT_TYPE =           "application/x-www-form-urlencoded"

let AUTHORIZATION =                 "Authorization"
let CONTENT_TYPE =                  "Content-Type"

let X_ACCESS_TOKEN =                "X-Access-Token"

let URL_LOGIN =                     "auth/tokens"
let URL_LOGIN_FACEBOOK =            "auth/tokens/facebooks"
let URL_REFRESH_TOKEN =             "auth/tokens/refresh"
let URL_REGISTER =                  "members"
let URL_PREFECTURES =               "prefectures"
let URL_CITIES =                    "cities"
let URL_SHOPS =                     "shops"
let URL_PASSWORD_CHANGE =           "members/passwords"
let URL_PASSWORD_FORGOT =           "members/passwords/reset"
let URL_EMAIL_CHANGE =              "members/emails"
let URL_ACCOUNT_INFO =              "members/details"
let URL_PHARMACIST_INFO =           "members/pharmacists"
let URL_MEMBERS_SHOPS =             "members/shops"
let URL_NOTIFICATION =              "members/settings/notices"
let URL_GOAL =                      "members/goals"
let URL_MEMBERS_IMAGES =            "members/images"
let URL_SUMMARY =                   "members/summaries"
let URL_MEMBERS_MESSAGES =          "members/messages"
let URL_MEMBERS_MESSAGES_UNREAD =   "members/messages/unreads"
let URL_MEMBERS_SHOPS_APPROVALS =   "members/shops/approvals"
let URL_BANNERS =                   "banners"

//MARK: API Parameters key
//Login
let LOGIN_PARAM_EMAIL =             "email"
let LOGIN_PARAM_PASSWORD =          "password"
let LOGIN_PARAM_DEVICE_ID =         "device_id"
let LOGIN_PARAM_DEVICE_TOKEN =      "device_token"
let LOGIN_PARAM_DEVICE_TYPE =       "device_type"

//Register
let REGISTER_PARAM_EMAIL =          "email"
let REGISTER_PARAM_PASSWORD =       "password"
let REGISTER_PARAM_FIRST_NAME =     "first_name"
let REGISTER_PARAM_LAST_NAME =      "last_name"
let REGISTER_PARAM_FIRST_NAME_KATA = "first_name_kana"
let REGISTER_PARAM_LAST_NAME_KATA = "last_name_kana"
let REGISTER_PARAM_GENDER_TYPE =    "sex"
let REGISTER_PARAM_BIRTHDAY =       "birthday"
let REGISTER_PARAM_DEVICE_ID =      "device_id"
let REGISTER_PARAM_DEVICE_TYPE =    "device_type"
let REGISTER_PARAM_DEVICE_TOKEN =   "device_token"
let REGISTER_PARAM_REGISTER_TYPE =  "register_type"
let REGISTER_PARAM_FACEBOOK_ID =    "facebook_id"
let REGISTER_PARAM_FACEBOOK_TOKEN = "facebook_token"
let REGISTER_PARAM_SHOP_ID =        "shop_id"
let REGISTER_PARAM_SHOP_NAME =      "shop_name"
let REGISTER_PARAM_IMAGE_PATH =     "image_path"
let REGISTER_PARAM_HEIGHT =         "height"

//Email change
let EMAIL_PARAM_CHANGE =            "email"

//Password change
let PASSWORD_PARAM_CHANGE_PASSWORD =      "password"
let PASSWORD_PARAM_CHANGE_NEW_PASSWORD =  "new_password"

//Notification setting
let NOTIF_TURNON =                  "1"
let NOTIF_TURNOFF =                 "2"
let NOTIF_PARAM_PUSHED =            "is_pushed"
let NOTIF_PARAM_SHOP =              "is_received_shop"
let NOTIF_PARAM_OPERATOR =          "is_received_operator"
let NOTIF_PARAM_WEIGHT =            "is_received_weight"
let NOTIF_PARAM_BREAKFAST =         "is_received_breakfast"
let NOTIF_PARAM_LUNCH =             "is_received_lunch"
let NOTIF_PARAM_DINNER =            "is_received_dinner"
let NOTIF_PARAM_SNACK =             "is_received_snack"
let NOTIF_PARAM_TIME_WEIGHT =       "weight_time"
let NOTIF_PARAM_TIME_BREAKFAST =    "breakfast_time"
let NOTIF_PARAM_TIME_LUNCH =        "lunch_time"
let NOTIF_PARAM_TIME_DINNER =       "dinner_time"
let NOTIF_PARAM_TIME_SNACK =        "snack_time"


//Goal
let GOAL_ID =                       "id"
let GOAL_WEIGHT =                   "weight"
let GOAL_STEPS =                    "steps"
let GOAL_STEP =                     "step"

//Pharmacist
let PHARMACIST_ID =                 "id"
let PHARMACIST_NAME =               "name"
let PHARMACIST_TEL =                "tel"
let PHARMACIST_EMAIL =              "email"
let PHARMACIST_NOTE =               "note"

//Summary
let SUMMARY_MEMBER_ID =             "member_id"
let SUMMARY_STEP =                  "step"
let SUMMARY_CALO =                  "calo"
let SUMMARY_UNREAD =                "unread"
let SUMMARY_CONSUMPT_CALO =         "consumpt_calo"
let SUMMARY_INTAKE_CALO =           "intake_calo"
let SUMMARY_STEP_PERCENT =          "stepcount_percent"

//MARK: UserDefaultsb
let DEVICE_ID =                     "deviceID"
let DEVICE_TYPE =                   "2"
let FB_TOKEN =                      "facebookToken"
let THEME_COLOR =                   "themeColor"
let PASSCODE =                      "passCode"

let ACCESS_TOKEN =                  "access_token"
let REFRESH_ACCESS_TOKEN =          "refresh_access_token"
let REFRESH_TOKEN =                 "refresh_token"

//search data 
let SEARCH_KEYWORD =                "search_keyword"
let SEARCH_PREFECTURE =             "search_prefecture"
let SEARCH_TOWN =                   "search_town"
let SEARCH_LAT =                    "search_lat"
let SEARCH_LON =                    "search_lon"
let SEARCH_TAB =                    "search_tab"
let SEARCH_PREFECTURE_NAME =        "search_prefecture_name"
let SEARCH_TOWN_NAME =              "search_town_name"

let ERROR =                         "errors"
let ERROR_CODE =                    "errorCode"
let EXPIRED_ACCESS_TOKEN =          "invalid_token"
let EXPIRED_REFRESH_TOKEN =         "expired_refresh_token"
let NOT_TOKEN =                     "not_token"

let DATA =                          "data"
let NAME =                          "name"
let PREFECTURE_ID =                 "prefecture_id"
let MESSAGE =                       "message"
let URL_IMAGE =                     "url"
let TITLE =                         "title"
let SENDER =                        "sender"

let STATUS =                        "status"
let CITY_ID =                       "city_id"
let CITY_CODE =                     "city_code"
let SHOP_NAME =                     "shop_name"
let LAT =                           "lattitude"
let LONG =                          "longtitude"
let PAGE =                          "page"
let LIST_BANNER =                   "listBanners"

//image
let ORIGIN =                        "origin"
let THUMB1 =                        "thumb1"
let AVATAR =                        "avatar"
//pharmacy
let ID =                            "id"
let SHOP_ID =                       "shop_id"
let SHOP_GROUP_ID =                 "shop_group_id"
let POS_SHOP_ID =                   "pos_shop_id"
let PHARMACY_CODE =                 "pharmacy_code"
let POST_CODE1 =                    "post_code1"
let POST_CODE2 =                    "post_code2"
let ADDRESS1 =                      "address1"
let ADDRESS2 =                      "address2"
let LATLON =                        "latlon"
let TEL =                           "tel"
let BUSSINESS_HOURS =               "bussiness_hours"
let HOLIDAY =                       "holiday"
let URL_KEY =                       "url"
let IMAGES =                        "images"
let CREATED_AT =                    "created_at"
let UPDATED_AT =                    "updated_at"
let SENT_AT =                       "sent_at"

let SHOP_STATUS =                   "shop_status"
// Message
let IS_READ =                       "is_read"

//notification - setting
let NOTIF_ALL =                     "notifAll"
let NOTIF_PHARMACY =                "notifPharmacy"
let NOTIF_TRICARE =                 "notifTricare"
let NOTIF_WEIGHT =                  "notifWeight"
let NOTIF_BREAKFAST =               "notifBreakfast"
let NOTIF_LUNCH =                   "notifLunch"
let NOTIF_DINNER =                  "notifDinner"
let NOTIF_SNACK =                   "notifSnack"

//MARK: Dictionary
//dicFacebookInfo
let FB_FIRSTNAME =                  "fbFirstName"
let FB_MIDDLENAME =                 "fbMiddleName"
let FB_LASTNAME =                   "fbLastName"
let FB_NAME =                       "fbName"
let FB_USERID =                     "fbUserID"
let FB_EMAIL =                      "fbEmail"
let FB_AVATAR =                     "fbAvatar"

//dicPasscode
let DIC_PASSCODE =                  "dicPassCode"

let ROTATION =                      "rotation"

//MARK: Http method
let HTTP_POST =                     "POST"
let HTTP_PUT =                      "PUT"
let HTTP_GET =                      "GET"
let HTTP_DELETE =                   "DELETE"

//MARK: RESULT CONSTANT
let RESULT_NO_DATA =                "RESULT_NO_DATA"
let RESULT_SUCCESS =                "RESULT_SUCCESS"
let RESULT_FAIL =                   "RESULT_FAIL"
let RESULT_FAIL_REFRESH_TOKEN =     "RESULT_FAIL_REFRESH_TOKEN"

//MARK: STATUS CODE
let STATUS_CODE_SUCCESS =           200
let STATUS_CODE_NO_CONTENT =        204
let STATUS_CODE_BAD_REQUEST =       400
let STATUS_CODE_UNAUTHORIZED =      401
let STATUS_CODE_NOT_FOUND =         404
