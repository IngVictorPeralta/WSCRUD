//
//  Post.swift
//  WSCRUD
//
//  Created by Victor Peralta on 07/10/23.
//

import Foundation

struct PostCod : Codable{
    let id : Int16
    let title : String
    let body : String
    let userId : Int16
}
