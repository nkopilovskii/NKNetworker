//
//  Models.swift
//  NKNetworker
//
//  Created by Nick Kopilovskii on 1/4/19.
//  Copyright © 2019 Nick Kopilovskii. All rights reserved.
//

import Foundation
import NKNetworker

//MARK: - EmptyRequestBody
class EmptyRequestBody: Encodable {}


//MARK: - User
class User: Codable {
  var id: Int
  var name, username, email, phone: String
  var address: Address
  var website: URL?
  var company: Company
  
  var description: String {
    return "<User: \(self) \nid: <\(id)> \nname: <\(name)> \nusername: <\(username)> \nemail: <\(email)> \naddress: <\(address)> \ntitle: <\(website?.absoluteString ?? "")> \ncompany: <\(company)> \n>\n\n"
  }
}

//MARK: - Address
extension User {
  struct Address: Codable {
    var street, suite, city, zipcode: String
    var geo: Geo
    
    var description: String {
      return "<Address: \nstreet: <\(street)> \nsuite: <\(suite)> \ncity: <\(city)> \nzipcode: <\(zipcode)> \ngeo: <\(geo)>  \n>\n"
    }
  }
}

//MARK: - Geo
extension User.Address {
  struct Geo: Codable {
    var lat, lng: Double
    
    var description: String {
      return "<Geo: \nlat: <\(lat)> \nlng: <\(lng)> \n>\n"
    }
  }
}

//MARK: - Company
extension User {
  struct Company: Codable {
    var name, catchPhrase, bs: String
    
    var description: String {
      return "<Company: \nname: <\(name)> \ncatchPhrase: <\(catchPhrase)> \nbs: <\(bs)>  \n>\n"
    }
  }
}

//MARK: - Post
class Post: Codable {
  var userId, id: Int
  var title, body: String
  
  var description: String {
    return "<Post: \(self) \nuserId: <\(userId)> \nid: <\(id)> \ntitle: <\(title)> \nbody: <\(body)> \n>\n\n"
  }
}

class ToDo: Codable {
  var userId, id: Int
  var title: String
  var completed: Bool
  
  var description: String {
    return "<ToDo: \(self) \nuserId: <\(userId)> \nid: <\(id)> \ntitle: <\(title)> \ncompleted: <\(completed)> \n>\n\n"
  }
}
