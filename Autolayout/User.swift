//
//  User.swift
//  Autolayout
//
//  Created by Tulin Akdogan on 4/5/15.
//  Copyright (c) 2015 Tulin Akdogan. All rights reserved.
//

import Foundation

struct User
{
    let name: String
    let company: String
    let login: String
    let password: String
    
    static func login(login: String, password: String) -> User? {
        if let user = database[login]{
            if user.password == password{
                return user
            }
        }
        return nil
    }
    
    static let database: Dictionary<String, User> = {
        var theDatabase = Dictionary<String, User>()
        for user in [
            User(name:"Tulin Akdogan", company:"CIBC", login:"takdogan", password:"abc"),
            User(name:"Caner Berkay Antmen", company:"Microsoft", login:"cbantmen", password:"asd"),
            User(name: "Kemal Akdogan", company:"ICP", login:"kakdogan", password:"kemal")
            ]{
            theDatabase[user.login] = user
        }
        return theDatabase
    }()
}