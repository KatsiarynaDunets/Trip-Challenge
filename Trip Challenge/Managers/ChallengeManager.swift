////
////  ViewController.swift
////  Trip Challenge
////
////  Created by Kate on 13/11/2023.
////
//
//
//import UIKit
//import CoreData
//
//class ChallengeManager {
//    private let context: NSManagedObjectContext
//
//    init(context: NSManagedObjectContext) {
//        self.context = context
//    }
//
////    func getAllChallenges() -> Result<[Challenges], Error> {
////        let request: NSFetchRequest<Challenge> = NSFetchRequest<Challenge>(entityName: "Challenges")
////        do {
////            let challenges = try context.fetch(request)
////            return .success(challenges)
////        } catch {
////            return .failure(error)
////        }
////    }
////}
////
////class SomeViewController: UIViewController {
////
////    var challengeManager: ChallengeManager!
////
////    override func viewDidLoad() {
////        super.viewDidLoad()
////
////        // Получаем контекст из AppDelegate
////        let appDelegate = UIApplication.shared.delegate as! AppDelegate
////        let context = appDelegate.persistentContainer.viewContext
////        challengeManager = ChallengeManager(context: context)
////
////        // Получаем данные и обрабатываем результат
////        let result = challengeManager.getAllChallenges()
////        switch result {
////        case .success(let challenges):
////            // Обработка успешного получения челленджей
////            print(challenges)
////        case .failure(let error):
////            // Обработка ошибки
////            print("Ошибка: \(error)")
////        }
////    }
//}
//
//
//
