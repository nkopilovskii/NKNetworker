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
    fetcher.errorHandler = PostList.defaultErrorHandler
    fetcher.printLogRequest = true
    fetcher.printLogResponse = true
    fetcher.get { [weak self] in
      switch $0 {
      case .success(let posts):
        posts.forEach({ post in
          DispatchQueue.main.async {
            self?.textLog.text.append(post.description)
          }
        })
      case .failure(let error):
        DispatchQueue.main.async {
          self?.textLog.text.append((error as? NKNError)?.errorMessage ?? error.localizedDescription)
        }
      case .exception(_): break
      }
    }
  }
  
  
  
  @IBAction func btnUserPostListTouchUpInside(_ sender: Any) {
    textLog.text = licence
    
    let userId = 5
    let fetcher = PostList(Endpoint.posts, query: [QueryParameter.userId(userId)], errorHandler: PostList.defaultErrorHandler)
    fetcher.get { [weak self] in
      switch $0 {
      case .success(let posts):
        posts.forEach({ post in
          DispatchQueue.main.async {
            self?.textLog.text.append(post.description)
          }
        })
      case .failure(let error):
      DispatchQueue.main.async {
        self?.textLog.text.append((error as? NKNError)?.errorMessage ?? error.localizedDescription)
      }
      case .exception(_): break
      }
    }
  }
  
  
  
  @IBAction func btnPostTouchUpInside(_ sender: Any) {
    textLog.text = licence
    
    let postId = 24
    let fetcher = SinglePost(Endpoint.posts, path: [PathParameter(key: nil, value: "\(postId)")], errorHandler: SinglePost.defaultErrorHandler)
    fetcher.get { [weak self] in
      switch $0 {
      case .success(let post):
        DispatchQueue.main.async {
          self?.textLog.text.append(post.description)
        }
      case .failure(let error):
      DispatchQueue.main.async {
        self?.textLog.text.append((error as? NKNError)?.errorMessage ?? error.localizedDescription)
      }
      case .exception(_): break
      }
    }
  }
  
  
  
  @IBAction func btnPostCreateTouchUpInside(_ sender: Any) {
    textLog.text = licence
    
    let userId = 4
    let newPost = Post(id: nil, userId: userId, title: "Title", body: "Body")
    
    
    let fetcher = SinglePost(Endpoint.posts, errorHandler: PostList.defaultErrorHandler)
    fetcher.post(newPost, then: { [weak self] in
      switch $0 {
      case .success(let post):
        DispatchQueue.main.async {
          self?.textLog.text.append(post.description)
        }
      case .failure(let error):
      DispatchQueue.main.async {
        self?.textLog.text.append((error as? NKNError)?.errorMessage ?? error.localizedDescription)
      }
      case .exception(_): break
      }
    })
  }
  
  
  
  @IBAction func btnPostDeleteTouchUpInside(_ sender: Any) {
    textLog.text = licence
    
    
    let postId = 24
    let fetcher = SinglePostEmptyResponse(Endpoint.posts, path: [PathParameter(key: nil, value: "\(postId)")], errorHandler: PostList.defaultErrorHandler)
    fetcher.delete { [weak self] in
      switch $0 {
      case .success(_):
        DispatchQueue.main.async {
          self?.textLog.text.append("Post #\(postId) successfully deleted!")
        }
      case .failure(let error):
      DispatchQueue.main.async {
        self?.textLog.text.append((error as? NKNError)?.errorMessage ?? error.localizedDescription)
      }
      case .exception(_):
        break
      }
    }
  }
  
}








