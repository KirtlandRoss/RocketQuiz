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

    //MARK:-- Rankings view related
    func avrgScore() -> [User]
    {
        var usrL = [User]()
        let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        let adminPredicate = NSPredicate(format: "name != %@", "Admin") // use predicate to reject the admin from the fetch
        let invalidPredicate = NSPredicate(format: "name != %@", "invalid") //get rid of invalid user
        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [adminPredicate, invalidPredicate]) //combine predicates

        fetchReq.predicate = compoundPredicate
        do
        {
            usrL = try context!.fetch(fetchReq) as! [User]
            for plyr in usrL
            {
                plyr.averageScore = plyr.calculateScore()
            }
            usrL.sort()
            usrL.reverse()

        }
        catch
        {
            print("Fetch attempt in DBHelper.avrgScore failed. error: \(error)")
        }

        return usrL
    }
    //MARK:-- Quiz related
    func updateQuizQuestions(_ username : String, _ qArray : [Bool]){
        let quizFetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "Quiz")
        quizFetchReq.predicate = NSPredicate(format: "user.name == %@", username)
        let quiz = try! context?.fetch(quizFetchReq).first as! Quiz

        for (n, _) in qArray.enumerated(){
            let quest = quiz.questions![n] as! QuizQuestion
            quest.answeredCorrect = qArray[n]
            print(qArray.count)
        }
        quiz.calculateGrade(qArray)
        try! context?.save()
    }

    func createQuiz(_ username : String){
        let qbFetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "QuestionBank")
        qbFetchReq.returnsObjectsAsFaults = false
        let userFetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        userFetchReq.predicate = NSPredicate(format: "name == %@", username)
        let user = try! context?.fetch(userFetchReq).first as! User

        if let qbFetch = try? context?.fetch(qbFetchReq).first as? QuestionBank{
            let quiz = Quiz(context: context!)
            quiz.setQuizQuestions(qbFetch.getQs())
            quiz.user = user
        }
        else{
            let qbank = QuestionBank(context: context!)
            qbank.addQ()
            let quiz = Quiz(context: context!)
            quiz.setQuizQuestions(qbank.getQs())
            quiz.user = user
        }
        try! context?.save()

    }
    //MARK:-- QuestionBank related
    func createQuestionBank(){
        let qbank = QuestionBank(context: context!)
        qbank.addQ()
        do{
            try context!.save()
            print("question bank created")
        }
        catch{
            self.context!.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            print("conflicts found, attempting overwrite")
            try! context!.save()
        }
    }

    func appendQuestionBank(question: String, answer: String, incorrectAnswers: [String]){
        let qbankFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Quiz")
        let qBank = try! context?.fetch(qbankFetch).first as! QuestionBank

        var qBankQuestion = BankedQuestion(context: context!)
        qBankQuestion.question = question
        qBankQuestion.correctAnswer = answer
        qBankQuestion.incorrectAnswers = incorrectAnswers

        qBank.addToQuestions(qBankQuestion)
        do{
            try context?.save()
        }
        catch{
            print("DBHelper.appendQuestionBank failure")
        }
    }
    //MARK:-- User management related
    func updateSubscriptionStatus(name: String, subscriptionStatus: Bool) {
        var user = User()
        let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "User")

        fetchReq.returnsObjectsAsFaults = false

        fetchReq.predicate = NSPredicate(format: "name == %@", name)

        do {
            let userFetch = try context!.fetch(fetchReq)

            if (userFetch.count != 0) {
                user = userFetch.first as! User
                user.hasSubscription = subscriptionStatus
                try context!.save()
                print("User info updated")
            }
        } catch {
            print("Error while trying to update user info")
        }
    }

    func getUserData() -> [User]{
        var stu = [User]()
        let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        do{
            stu=try context!.fetch(fetchReq) as! [User]
        }
        catch{
            print("cannot get data")
        }
        return stu
    }

    func getSubscriptionData(username : String) -> Bool {

        var user = User()
        let fetchReq = NSFetchRequest<NSManagedObject>.init(entityName: "User")
        fetchReq.returnsObjectsAsFaults = false
        fetchReq.predicate = NSPredicate(format: "name == %@", username)

        fetchReq.fetchLimit = 1
        do {
            let req = try context?.fetch(fetchReq) as! [User]

            if req.count != 0 {
                user = req.first!
            } else {
                print("User not found")
            }
        } catch {
            print("Error while trying to retrieve user")
        }
        return user.hasSubscription
    }

    func deleteUserData(_ name: String){
        let fetchReq = NSFetchRequest<NSManagedObject>.init(entityName: "User")
        fetchReq.predicate = NSPredicate(format: "name == %@", name)
        do {
            let st = try context!.fetch(fetchReq)
            context!.delete(st.first as! User)
            try context!.save()
            print("data deleted")
        }
        catch{
            print("DBhelper.deleteUserData err")
        }
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
    //MARK:-- Discussion Board related
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

    func getAllDiscussionPosts () -> [Dictionary<String, Any>] {
        var users = [User]()
        var posts : [Post] = []

        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Post")
        let sort = NSSortDescriptor(key: "date", ascending: false)
        request.sortDescriptors = [sort]
        
        let df = DateFormatter()
        df.timeStyle = .medium
        df.dateStyle = .medium
        df.dateFormat = "MM/dd/YYYY - hh:mm:ss"
//        let dStr = df.string(from: date)
//
//        let finalDate = df.date(from: dStr)

        //        fetchReq.returnsObjectsAsFaults = false

        do {
            posts = try context!.fetch(request) as! [Post]

        } catch {
            print("Error fetching user data")
        }
        return posts.map { Post in
            ["name": String(Post.user!.name!), "content": String(Post.content!), "date": df.string(from: Post.date!) ]
        }
    }

}

enum NilError : Error{
    case nilErr
}
