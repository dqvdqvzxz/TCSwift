//
//  TRCAPIKeyContant.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 6/26/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

//MARK: API
let HEADER_AUTHORIZATION = "Basic dG9yaV9hcHBfaW9zX3Rlc3Q6MmY1YzY5Njc4Mzg4NGIwMmEwNjkxNjNlOWI2ODAzMTI="
let HEADER_CONTENT_TYPE = "application/x-www-form-urlencoded"

let X_ACCESS_TOKEN =                "X-Access-Token"

let APP_DOMAIN = "http://172.16.210.122/api/"

let URL_LOGIN =                     "auth/tokens"
let URL_REGISTER =                  "members"
let URL_PREFECTURES =               "prefectures"
let URL_CITIES =                    "cities"
let URL_SHOPS =                     "shops"

//MARK: UserDefaults
let DEVICE_ID =                     "deviceID"
let DEVICE_TYPE =                   "2"
let FB_TOKEN =                      "facebookToken"
let THEME_COLOR =                   "themeColor"
let PASSCODE =                      "passCode"

let ACCESS_TOKEN =                  "access_token"
let REFRESH_ACCESS_TOKEN =          "refresh_access_token"

let DATA =                          "data"
let NAME =                          "name"
let PREFECTURE_ID =                 "prefecture_id"
let STATUS =                          "status"
let CITY_ID =                 "city_id"
let CITY_CODE =                 "city_code"
let SHOP_NAME =                 "shop_name"
let LAT =                 "lat"
let LONG =                 "lon"
//image
let ORIGIN =                          "origin"
let THUMB1 =                          "thumb1"

//pharmacy
let ID =                            "id"
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
let URL_KEY =                           "url"
let IMAGES =                        "images"

//notification - setting
let NOTIF_ALL = "notifAll"
let NOTIF_PHARMACY = "notifPharmacy"
let NOTIF_TRICARE = "notifTricare"
let NOTIF_WEIGHT = "notifWeight"
let NOTIF_BREAKFAST = "notifBreakfast"
let NOTIF_LUNCH = "notifLunch"
let NOTIF_DINNER = "notifDinner"
let NOTIF_SNACK = "notifSnack"

//MARK: Dictionary
//dicFacebookInfo
let FB_FIRSTNAME = "fbFirstName"
let FB_MIDDLENAME = "fbMiddleName"
let FB_LASTNAME = "fbLastName"
let FB_NAME = "fbName"
let FB_USERID = "fbUserID"
let FB_EMAIL = "fbEmail"
let FB_AVATAR = "fbAvatar"

//dicPasscode
let DIC_PASSCODE = "dicPassCode"

//MARK: Http method
let HTTP_POST = "POST"
let HTTP_PUT = "PUT"
let HTTP_GET = "GET"
let HTTP_DELETE = "DELETE"
