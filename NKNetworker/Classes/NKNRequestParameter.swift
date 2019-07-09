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
