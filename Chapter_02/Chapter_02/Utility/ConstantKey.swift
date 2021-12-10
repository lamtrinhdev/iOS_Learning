//
//  ConstantKey.swift
//  Chapter_02
//
//  Created by Lam Trinh Tran Truc on 10-December-2021.
//

import Foundation

enum DateFormat: String {
    case yyyyMMdd = "yyyy-MM-dd"
}

// Param Key
let kParamKeyAppID = "?appid="
let kParamKeyCity = "&q="
let kParamKeyNumberOfDays = "&cnt="
let kParamKeyUnit = "&units="

// Deafult Value
let kDefaultTotalDaysRequest    = 7
let kDefaultValueTempUnit       = "metric"
let kDefaultTimeoutURLRequest   = 20
