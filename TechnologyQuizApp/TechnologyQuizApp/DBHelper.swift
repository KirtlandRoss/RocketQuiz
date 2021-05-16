//
//  DBHelper.swift
//  ResortFeedbackApp
//
//  Created by Kirtland Ross on 4/27/21.
//

import Foundation
import CoreData
import SwiftUI

class DBHelper{
    static var inst = DBHelper()

    let context = SceneDelegate().context

    func createQuiz(_ username : String){
        let qbFetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "QuestionBank")
        qbFetchReq.returnsObjectsAsFaults = false
        let qbFetch = try! context?.fetch(qbFetchReq).first as! QuestionBank

        let userFetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        userFetchReq.predicate = NSPredicate(format: "name == %@", username)
        let user = try! context?.fetch(userFetchReq).first as! User

        var quiz = Quiz(context: context!)
        quiz.setQuizQuestions(qbFetch.getQs())
        quiz.user = user
        try! context?.save()

    }

    func updateUserPassword (object: [String : String]) {
        var user = User()
        let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "User")

        fetchReq.returnsObjectsAsFaults = false

        fetchReq.predicate = NSPredicate(format: "name == %@", object["name"]!)

        do {
            let userFetch = try context!.fetch(fetchReq)

            if (userFetch.count != 0) {
                user = userFetch.first as! User
                user.password = object["password"]
                try context!.save()
                print("User info updated")
            }
        } catch {
            print("Error while trying to update user info")
        }
    }

    func addDiscussionPost(_ name: String, _ message: String){
        var user = User()
        var posts : Array<Any>
        var post2 : Post = Post(context: context!)
        var discussionBoard = DiscussionBoard(context: context!)
        let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchReq.predicate = NSPredicate(format: "name == %@", name)
        fetchReq.returnsObjectsAsFaults = false
        
        let date = Date()
        
        do {
            let userFetch = try context!.fetch(fetchReq)
            print(userFetch)
            
            if (userFetch.count != 0) {
                user = userFetch.first as! User
                print(user)
                if user.posts?.allObjects as? [Post] != nil {
                    posts = user.posts?.allObjects as! [Post]
                    post2.content = message
                    post2.date = date
                    post2.discussionBoard = discussionBoard
                    post2.user = user
                    posts.append(post2)
                    try! context!.save()
                    print(posts)
                    print("Messages Updated")
                } else {
                    print("something went wrong")
                }
            } else {
                print("count not find user")
            }
        } catch {
            print("Error while trying to update user info")
        }
    }
    
    func getAllDiscussionPosts () -> [Dictionary<String, String>] {
        var users = [User]()
        var posts : [Post] = []

            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Post")
            let sort = NSSortDescriptor(key: "date", ascending: false)
            request.sortDescriptors = [sort]


//        fetchReq.returnsObjectsAsFaults = false
        
        do {
            posts = try context!.fetch(request) as! [Post]

        } catch {
            print("Error fetching user data")
        }
        return posts.map { Post in
            ["name": String(Post.user!.name!), "content": String(Post.content!)]
        }
    }
    
}

enum NilError : Error{
    case nilErr
}
