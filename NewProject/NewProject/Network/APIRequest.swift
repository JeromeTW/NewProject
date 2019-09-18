// APIRequest.swift
// Copyright (c) 2019 Jerome Hsieh. All rights reserved.
// Created by Jerome Hsieh on 2019/9/18.

import Foundation

enum HTTPMethod: String {
  case get = "GET"
  case post = "POST"
}

struct HTTPHeader {
  let field: String
  let value: String
}

struct APIRequest {
  var url: URL
  let method: HTTPMethod
  var queryItems: [URLQueryItem]?
  var headers: [HTTPHeader]?
  var body: Data?

  init(url: URL, method: HTTPMethod = .get, bodyData: Data? = nil) {
    self.url = url
    self.method = method
    body = bodyData
  }

  init<JSONObject: Encodable>(url: URL, method: HTTPMethod = .get, jsonObject: JSONObject) throws {
    self.url = url
    self.method = method
    body = try JSONEncoder().encode(jsonObject)
  }
}

struct APIResponse<Body> {
  let statusCode: Int
  let body: Body
}

// MARK: - For JSON Object

extension APIResponse where Body == Data? {
  func decode<BodyType: Decodable>(to _: BodyType.Type) throws -> APIResponse<BodyType> {
    guard let data = body else {
      throw APIError.decodingFailure
    }
    let decodeJSON = try JSONDecoder().decode(BodyType.self, from: data)
    return APIResponse<BodyType>(statusCode: statusCode, body: decodeJSON)
  }
}

enum APIError: Error {
  case invalidURL
  case requestFailed
  case decodingFailure
  case unknown(error: Error)
}
