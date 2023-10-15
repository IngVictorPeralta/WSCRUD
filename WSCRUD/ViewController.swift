//
//  ViewController.swift
//  WSCRUD
//
//  Created by Victor Peralta on 07/10/23.
//

import UIKit

class ViewController: UIViewController {

    let postService = PostServiceManager()
    //var myPost = PostCod(id: nil, title: "Hello Post", body: "Post content",userId: 1)
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let postDataManager = PostDataManager(context: context)
        /*postService.getAllPost(PDM: postDataManager){ getPosts in
            if let getPosts = getPosts{
                print("me traje los posts:",getPosts)
            }else{
                print("Error: Failed to create post")
            }
            
        }*/
        // Do any additional setup after loading the view.
        //create
        /*postService.createPost(post: myPost){ createdPost in
            if let createdPost = createdPost{
                print("created post:",createdPost)
            }else{
                print("Error: Failed to create post")
            }
            
        }*/
        //update
        /*myPost = Post(id: 50, title: "updated post", body: "New content", userId: 5)
                postService.updatePost(post: myPost){ updatePost in
                    if let updatePost = updatePost{
                        print("updted post:", updatePost)
                    }
                    else{
                        print("Error: Failed to update post")
                    }
                }*/
        //delete
        /*postService.deletePost(id: 50){statusCode in
            
            if statusCode == 200{
                print("Post deleted")
                
            }else{
                print("Failed to delete post")
            }
        }*/
        
    }


}

