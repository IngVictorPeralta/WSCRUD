//
//  PostDataManager.swift
//  WSCRUD
//
//  Created by Victor Peralta on 14/10/23.
//

import Foundation
import CoreData

class PostDataManager{
    private var posts : [ItemPost] = []
    
    private let context: NSManagedObjectContext
    init(context : NSManagedObjectContext){
        self.context = context
    }
    
    func countPosts() -> Int {
        return posts.count
    }
    
    func createPost(id : Int16, userId : Int16, title : String, body: String ){
        let newPost = ItemPost(context: context)
        newPost.id = id
        newPost.userId = userId
        newPost.body = body
        newPost.title = title
        
        do{
            try context.save()
            return 
        }catch let error{
            print("Error: ",error)
            return
        }
    }
    
    func getAllPosts(){
        posts = []
        if let postsDB = try? self.context.fetch(ItemPost.fetchRequest()){
            posts = postsDB
        }
    }
    
    func getPost(at index: Int) -> ItemPost{
        return posts[index]
    }

    func deletePost(post: ItemPost) -> Bool{
        self.context.delete(post)
        print("borrando",post)
        do{
            try context.save()
            return true
        }catch let error{
            print("Error: ",error)
            return false
        }
    }
    
    func deleteAllPosts() {
        if let postsDB = try? self.context.fetch(ItemPost.fetchRequest()) {
            for post in postsDB {
                self.context.delete(post as NSManagedObject)
            }
            do {
                try self.context.save()
                self.posts = [] // Vacía el arreglo local de posts
            } catch let error {
                print("Error: ", error)
            }
        }
    }
}
