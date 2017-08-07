//
//  JSONParsing.swift
//  hplus-sport
//
//  Created by Saul Mora on 5/6/17.
//  Copyright © 2017 Lynda.com. All rights reserved.
//

import Foundation

protocol JSONDecodable {
  init(_ decoder: JSONDecoder) throws
}

typealias JSONObject = [String: Any]

enum JSONParsingError: Error
{
  case missingKey(key: String)
  case typeMismatch(key: String)
}

class JSONDecoder
{
  let jsonObject: JSONObject
  init(_ jsonObject: JSONObject)
  {
    self.jsonObject = jsonObject
  }
  
  func value<T>(forKey key: String) throws -> T
  {
    guard let value = jsonObject[key] else {
      throw JSONParsingError.missingKey(key: key)
    }
    if (value is NSNull) {
        return "" as! T
    }
    guard let finalValue = value as? T else {
      throw JSONParsingError.typeMismatch(key: key)
    }
    return finalValue
  }
  
  static let defaultDateFormat = "dd/MM/yyyy HH:mm:ss"
  private lazy var dateFormatter = DateFormatter()
  
  func value(forKey key: String, format: String = JSONDecoder.defaultDateFormat) throws -> Date
  {
    let dateValue: String = try value(forKey: key)
    dateFormatter.dateFormat = format
    guard let returnValue = dateFormatter.date(from: dateValue) else {
      throw JSONParsingError.typeMismatch(key: key)
    }
    return returnValue
  }
}

func parseArray<T>(_ objects: [JSONObject]) throws -> [T] where T: JSONDecodable
{
//  guard let objects = json as? [JSONObject] else { return [] }
  let jsonObjects: [JSONObject] = objects
  return try jsonObjects.map(decode)
}

func parseDict<T>(_ object: JSONObject) throws -> T where T: JSONDecodable
{
    return try T.init(JSONDecoder(object))
}

func deserialize(_ data: Data) throws -> [JSONObject]
{
  let json = try JSONSerialization.jsonObject(with: data, options: [])
  guard let objects = json as? [JSONObject] else { return [] }
  
  return objects
}

func decode<T>(_ jsonObject: JSONObject) throws -> T where T: JSONDecodable
{
  return try T.init(JSONDecoder(jsonObject))
}
















