//
//  PostsController.swift
//  WSCRUD
//
//  Created by Victor Peralta on 14/10/23.
//

import UIKit

class PostViewController: UITableViewController {

    
    let postService = PostServiceManager()
    //var myPost = PostCod(id: nil, title: "Hello Post", body: "Post content",userId: 1)
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var postDataManager : PostDataManager?
    var rowsPosts = 0
    
    @IBOutlet var tablePosts: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("cargo...")
        postDataManager = PostDataManager(context: context)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        anyPost()
    }
    func anyPost(){
        print("recargando base")
        postDataManager?.getAllPosts()
        rowsPosts = postDataManager?.countPosts() ?? 0
        if (rowsPosts) < 1{
            downloadBack()
        }
        
        print("anyPosts->",rowsPosts)
        
        
    }
    func downloadBack(){
        rowsPosts = 0
        print("ACTUALIZANDO DESDE BACK")
        postService.getAllPost(PDM: postDataManager!){ (posts) in
            if let posts = posts {
                // Los datos se han descargado y se han procesado correctamente.
                // Puedes trabajar con los datos aquí.
                // Por ejemplo, puedes actualizar la interfaz de usuario con los datos de los posts.
                print("Se descargaron \(posts.count) posts")
                self.tablePosts.reloadData()
            } else {
                // Ocurrió un error durante la descarga o el procesamiento de datos.
                // Maneja el error de acuerdo a tus necesidades.
                print("Ocurrió un error al descargar los posts")
            }
            
        }
        
        /*{ getPosts in
            if let getPosts = getPosts{
                print("me traje los posts:",getPosts)
            }else{
                print("Error: Failed to create post")
            }
            
        }*/
        

    }
    @IBAction func reload(_ sender: Any) {
        downloadBack()
        
        rowsPosts = 0
        tableView.reloadData()
        sleep(2)
        anyPost()
        tableView.reloadData()
    }
    
    
    
    // MARK: - Table view data source

    /*override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return postDataManager?.countPosts()
    }*/

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //let n = postDataManager?.countPosts() ?? 0
        //print("debo generar n renglones",n)
        //return n
        //return postDataManager?.countPosts() ?? 0
        return rowsPosts
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell

        // Configure the cell...
        if let actualPost = postDataManager?.getPost(at: indexPath.row){
            
            cell.titlePost.text = actualPost.title
            cell.bodyPost.text = actualPost.body
            cell.userIdPost.text = String(actualPost.userId)
            cell.IdPost.text = String(actualPost.id)
        }
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            if let delPost = postDataManager?.getPost(at: indexPath.row){
                if let posible = postDataManager?.deletePost(post:delPost){
                    anyPost()
                    tableView.deleteRows(at: [indexPath], with: .fade)
                    print("YA SE BORRO")
                    
                }
            }
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
