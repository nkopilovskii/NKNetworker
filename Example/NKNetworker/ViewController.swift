//
//  ViewController.swift
//  NKNetworker
//
//  Created by nkopilovskii on 01/04/2019.
//  Copyright (c) 2019 nkopilovskii. All rights reserved.
//

import UIKit
import NKNetworker

//typealias EntityFetcher = NKNRequestFetcher<Encodable, Decodable>
typealias SinglePost = NKNEntityRequestFetcher<Post, Post>
typealias PostList = NKNListRequestFetcher<[Post], Post>

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  @IBAction func btnTouchUpInside(_ sender: Any) {
    let fetcher = PostList(Endpoint.posts)
    fetcher.get { [weak self] in
      switch $0 {
      case .success(let posts):
        posts.forEach({ print($0.description)})
        self?.test(posts)
      case .failure(_):
        break
      case .exception(_): break
      }
    }
  }
  
  
  
  func test(_ posts: [Post]) {
    PostList(Endpoint.posts).put(posts) {
      switch $0 {
      case .success(let posts):
        posts.forEach({ print($0.description)})
      case .failure(_):
        break
      case .exception(_): break
      }
    }
  }
  
}








