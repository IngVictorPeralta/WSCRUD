//
//  PostServiceManager.swift
//  WSCRUD
//
//  Created by Victor Peralta on 07/10/23.
//

import Foundation

class PostServiceManager{
    static let shared = PostServiceManager()
    
    
    init(){
        
    }
    /*func getAllPost(PDM: PostDataManager) -> Bool{
        guard let url = URL(string: Constants.postURL) else {

            return false
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type") //value - key
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            /*if let data = data {
                if let dataString = String(data: data, encoding: .utf8) {
                    print("Respuesta: \(dataString)")
                    // Puedes procesar la respuesta JSON u otro tipo de datos aquí
                    
                }
            }*/
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let responseObject = try decoder.decode([PostCod].self, from: data)
                    // Reemplaza YourResponseType con el tipo de objeto Swift que esperas recibir en la respuesta JSON
                    PDM.deleteAllPosts()
                    // Ahora puedes trabajar con responseObject, que es un objeto Swift deserializado
                    for post in responseObject{
                        print(post)
                        PDM.createPost(id: post.id, userId: post.userId, title: post.title, body: post.body)
                    }
                    PDM.getAllPosts()
                    return
                } catch {
                    print("Error al decodificar la respuesta JSON: \(error)")
                    return
                }
            }

        }

            task.resume()
        return true
      
    }*/
    
    
    func getAllPost(PDM: PostDataManager,completion: @escaping ([PostCod]?) -> Void) {
        guard let url = URL(string: Constants.postURL) else {
            completion(nil)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type") //value - key
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            /*if let data = data {
                if let dataString = String(data: data, encoding: .utf8) {
                    print("Respuesta: \(dataString)")
                    // Puedes procesar la respuesta JSON u otro tipo de datos aquí
                    
                }
            }*/
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let responseObject = try decoder.decode([PostCod].self, from: data)
                    // Reemplaza YourResponseType con el tipo de objeto Swift que esperas recibir en la respuesta JSON
                    PDM.deleteAllPosts()
                    // Ahora puedes trabajar con responseObject, que es un objeto Swift deserializado
                    for post in responseObject{
                        print(post)
                        PDM.createPost(id: post.id, userId: post.userId, title: post.title, body: post.body)
                    }
                    PDM.getAllPosts()
                } catch {
                    print("Error al decodificar la respuesta JSON: \(error)")
                }
            }

        }

            task.resume()
      
    }
    
    func createPost(post : PostCod, completion: @escaping (PostCod?) -> Void) {
        guard let url = URL(string: Constants.postURL) else {
            completion(nil)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type") //value - key
        
        do {
            //Encode our post
            let jsonData = try JSONEncoder().encode(post)
            
            print("JSON:", try JSONSerialization.jsonObject(with: jsonData) )
            request.httpBody = jsonData
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let data = data {
                    //Handle response data
                    if let createdPost = try? JSONDecoder().decode(PostCod.self, from: data) {
                        completion(createdPost)
                    }
                } else if let error = error {
                    print("Error:", error)
                    completion(nil)
                }
            }
            task.resume()
        } catch let error{
            print("Error:", error)
            completion(nil)
        }
    }
    //Update method
    func updatePost(post : PostCod, completion: @escaping (PostCod?) -> Void) {
            let urlString = Constants.postURL + String(post.id)
            print("urlString:", urlString)
            guard let url = URL(string: urlString) else {
                completion(nil)
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type") //value - key
        
            do {
                //Encode our post
                let jsonData = try JSONEncoder().encode(post)
                print("JSON:", try JSONSerialization.jsonObject(with: jsonData) )
                request.httpBody = jsonData
                
                let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                    if let data = data {
                        //Handle response data
                        if let updatedPost = try? JSONDecoder().decode(PostCod.self, from: data) {
                            completion(updatedPost)
                        }
                    } else if let error = error {
                        print("Error:", error)
                        completion(nil)
                    }
                }
                task.resume()
            } catch let error{
                print("Error:", error)
                completion(nil)
            }
        }
    //Delete
    func deletePost(id: Int, completion: @escaping (Int) -> Void) {
        let urlString = Constants.postURL + String(id)
        print("urlString:", urlString)
        
        guard let url = URL(string: urlString) else {
            completion(0)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                completion(response.statusCode)
            } else if let error = error {
                print("Error:", error)
                completion(0)
            }
        }
        task.resume()
    }
}
