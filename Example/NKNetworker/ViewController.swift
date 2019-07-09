//
//  ViewController.swift
//  NKNetworker
//
//  Created by nkopilovskii on 01/04/2019.
//  Copyright (c) 2019 nkopilovskii. All rights reserved.
//

import UIKit
import NKNetworker

typealias SinglePost = NKNEntityRequestFetcher<Post, Post>
typealias SinglePostEmptyResponse = NKNEntityRequestFetcher<EmptyBody, Post>
typealias PostList = NKNListRequestFetcher<[Post], Post>

class ViewController: UIViewController {
  
  @IBOutlet weak var textLog: UITextView!
  
  var licence = "Copyright (c) 2019 nkopilovskii <nkopilovskii@gmail.com> \n\n\n\n\n"
  
  @IBAction func btnPostListTouchUpInside(_ sender: Any) {
    textLog.text = licence
    let fetcher = PostList(Endpoint.posts)
    fetcher.get { [weak self] in
      switch $0 {
      case .success(let posts):
        posts.forEach({ post in
          DispatchQueue.main.async {
            self?.textLog.text.append(post.description)
          }
        })
      case .failure(_):
        break
      case .exception(_): break
      }
    }
  }
  
  
  
  @IBAction func btnUserPostListTouchUpInside(_ sender: Any) {
    textLog.text = licence
    
    let userId = 5
    let fetcher = PostList(Endpoint.posts, query: [QueryParameter.userId(userId)])
    fetcher.get { [weak self] in
      switch $0 {
      case .success(let posts):
        posts.forEach({ post in
          DispatchQueue.main.async {
            self?.textLog.text.append(post.description)
          }
        })
      case .failure(_):
        break
      case .exception(_): break
      }
    }
  }
  
  
  
  @IBAction func btnPostTouchUpInside(_ sender: Any) {
    textLog.text = licence
    
    let postId = 24
    let fetcher = SinglePost(Endpoint.posts, path: [PathParameter(key: nil, value: "\(postId)")])
    fetcher.get { [weak self] in
      switch $0 {
      case .success(let post):
        DispatchQueue.main.async {
          self?.textLog.text.append(post.description)
        }
      case .failure(_):
        break
      case .exception(_): break
      }
    }
  }
  
  
  
  @IBAction func btnPostCreateTouchUpInside(_ sender: Any) {
    textLog.text = licence
    
    let userId = 4
    let newPost = Post(id: nil, userId: userId, title: "Title", body: "Body")
    
    
    let fetcher = SinglePost(Endpoint.posts)
    fetcher.post(newPost, then: { [weak self] in
      switch $0 {
      case .success(let post):
        DispatchQueue.main.async {
          self?.textLog.text.append(post.description)
        }
      case .failure(_):
        break
      case .exception(_): break
      }
    })
  }
  
  
  
  @IBAction func btnPostDeleteTouchUpInside(_ sender: Any) {
    textLog.text = licence
    
    
    let postId = 24
    let fetcher = SinglePostEmptyResponse(Endpoint.posts, path: [PathParameter(key: nil, value: "\(postId)")])
    fetcher.delete { [weak self] in
      switch $0 {
      case .success(_):
        DispatchQueue.main.async {
          self?.textLog.text.append("Post #\(postId) successfully deleted!")
        }
      case .failure(_):
        DispatchQueue.main.async {
          self?.textLog.text.append("Something went wrong!")
        }
      case .exception(_):
        break
      }
    }
  }
  
}








