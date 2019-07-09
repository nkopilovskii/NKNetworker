//
//Copyright (c) 2019 nkopilovskii <nkopilovskii@gmail.com>
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in
//all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//THE SOFTWARE.
//
//  NKNError.swift
//  NKNetworker
//
//  Created by Nick Kopilovskii on 7/9/19.
//

import Foundation

//MARK: - NKNError protocol
public protocol NKNError: Error {
  var errorMessage: String? { get }
}
//MARK: -


//MARK: - NKNStaticError. Base NKNError implementation
public enum NKNStaticError: Error, NKNError {
  case unknown
  case invalidURL
  case invalidRequest
  case noInternetConnection
  case undecoded
  case emptyResponseData
  
  public var errorMessage: String? {
    switch self {
    case .unknown: return "[NKNetworker.NKNStaticError] Unknown Error"
    case .invalidURL: return "[NKNetworker.NKNStaticError] Invalid URL"
    case .invalidRequest: return "[NKNetworker.NKNStaticError] Invalid HTTP Request"
    case .noInternetConnection: return "[NKNetworker.NKNStaticError] No Internet Connection"
    case .undecoded: return "[NKNetworker.NKNStaticError] Data received in the response can not be decoded to the entity of current type."
    case .emptyResponseData: return "[NKNetworker.NKNStaticError] Response contains no data"
    }
  }
}
//MARK: -
