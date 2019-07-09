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
//  NKNRequestParameter.swift
//  NKNetworker
//
//  Created by Nick Kopilovskii on 7/9/19.
//

import Foundation

//MARK: - Typealias
public typealias NKNHeaderParameters = [NKNRequestParameter]
public typealias NKNPathParameters = [NKNPathParameter]
public typealias NKNQueryParameters = [NKNQueryParameter]
//MARK: -

//MARK: - RequestParameter protocol
public protocol NKNRequestParameter {
  var key: String? { get }
  var value: String? { get }
}
//MARK: -

//MARK: - PathParameter protocol
public protocol NKNPathParameter: NKNRequestParameter {}


//MARK: - QueryParameter protocol
public protocol NKNQueryParameter: NKNRequestParameter {
  var stringValue: String? { get }
}
//MARK: -

//MARK: QueryParameter base extension
public extension NKNQueryParameter {
  var stringValue: String? {
    var str = String()
    if let key = key {
      str.append(key + "=")
    }
    str.append(value ?? "")
    return str
  }
}
//MARK: -
