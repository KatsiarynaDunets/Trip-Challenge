//
//  DataManager.swift
//  Trip Challenge
//
//  Created by Kate on 24/01/2024.
//

import CoreData
import UIKit

class DataManager { //класс можно использовать в любом месте (VC) приложения для работы с данными. DataManager предназначен для управления всеми операциями с данными в приложении, включая создание, чтение, обновление и удаление (CRUD) данных.
    
    static let shared = DataManager()
    
    private init() {} // Приватный инициализатор для синглтона
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Challenges")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
    let image1 = UIImage(named: "Image 1")!.jpegData(compressionQuality: 0.7)!
    let image2 = UIImage(named: "Image 2")!.jpegData(compressionQuality: 0.7)!
    let image3 = UIImage(named: "Image 3")!.jpegData(compressionQuality: 0.7)!
    let image4 = UIImage(named: "Image 4")!.jpegData(compressionQuality: 0.7)!
    let image5 = UIImage(named: "Image 5")!.jpegData(compressionQuality: 0.7)!
    let image6 = UIImage(named: "Image 6")!.jpegData(compressionQuality: 0.7)!
    let image7 = UIImage(named: "Image 7")!.jpegData(compressionQuality: 0.7)!
    let image8 = UIImage(named: "Image 8")!.jpegData(compressionQuality: 0.7)!
    let image9 = UIImage(named: "Image 9")!.jpegData(compressionQuality: 0.7)!
    let image10 = UIImage(named: "Image 10")!.jpegData(compressionQuality: 0.7)!
    let image11 = UIImage(named: "Image 11")!.jpegData(compressionQuality: 0.7)!
    let image12 = UIImage(named: "Image 12")!.jpegData(compressionQuality: 0.7)!
    let image13 = UIImage(named: "Image 13")!.jpegData(compressionQuality: 0.7)!
    let image14 = UIImage(named: "Image 14")!.jpegData(compressionQuality: 0.7)!
    let image15 = UIImage(named: "Image 15")!.jpegData(compressionQuality: 0.7)!
    let image16 = UIImage(named: "Image 16")!.jpegData(compressionQuality: 0.7)!
    
    
    
    func addKrakowPOIs() {
        let context = persistentContainer.viewContext
        
        let pois = [
            (poiCategory: "Средневековье", poiDescription: "Представляет собой защитное сооружение, расположенное перед Старым городом. Один из немногих сохранившихся средневековых барбаканов в Европе.", poiID: 1, poiImage: image1 , poiLat: 50.06556388793115, poiLocation: "50.06556388793115, 19.94162574007381", poiLon: 19.94162574007381 , poiNumber: 1, poiPromo: false, poiStatus: "Доступен" , title: "Барбакан"),
            
            (poiCategory: "Средневековье", poiDescription: "Один из символов Кракова, известен своими внутренними убранствами и ежедневным зовом трубача, который звучит с одной из его башен.", poiID: 2, poiImage: image2, poiLat: 50.06167506873804, poiLocation: "50.06167506873804, 19.939269299798678", poiLon: 19.939269299798678, poiNumber: 2, poiPromo: false , poiStatus: "Доступен" , title: "Мариацкий костел"),
            
            (poiCategory: "Средневековье", poiDescription: "Сердце Старого города и одна из крупнейших средневековых площадей в Европе, окруженная историческими зданиями, торговыми рядами и кафе.", poiID: 3, poiImage: image3, poiLat: 50.06167506873804, poiLocation: "50.06167506873804, 19.939269299798678", poiLon: 19.939269299798678 , poiNumber: 3, poiPromo: false , poiStatus: "Доступен" , title: "Рыночная площадь (Rynek Główny)"),
            
            (poiCategory: "Средневековье", poiDescription: "Богато украшенная католическая церковь в стиле барокко с еженедельными демонстрациями работы маятника Фуко.", poiID: 4 , poiImage: image4, poiLat: 50.05711011810121, poiLocation: "50.05711011810121, 19.938570055043282", poiLon: 19.938570055043282, poiNumber: 4, poiPromo: false , poiStatus: "Доступен" , title: "Костел святых Петра и Павла"),
            
            (poiCategory: "Средневековье", poiDescription: "Символ польской государственности и культуры, древняя резиденция польских королей. Замок включает в себя ряд зданий, каждое из которых уникально по своему архитектурному стилю.", poiID: 5, poiImage: image5 , poiLat:50.05451062920299 , poiLocation: "50.05451062920299, 19.93492129223292", poiLon: 19.93492129223292, poiNumber: 5, poiPromo: false , poiStatus: "Доступен" , title: "Вавельский замок"),
            
            
            (poiCategory: "Культура", poiDescription: "Содержит богатые коллекции польского искусства от средневековья до современности, включая известные произведения Яна Матейко.", poiID: 6, poiImage: image6 , poiLat: 50.06065494915645 , poiLocation: "50.06065494915645, 19.92361854069063", poiLon: 19.92361854069063 , poiNumber: 1, poiPromo: false , poiStatus: "Доступен" , title: "Национальный музей в Кракове"),
            
            (poiCategory: "Культура", poiDescription: "Один из старейших и наиболее уважаемых театров в Польше, известен своей великолепной архитектурой и историей.", poiID: 7, poiImage: image7, poiLat: 50.06403848711694 , poiLocation: "50.06403848711694, 19.942753509784144", poiLon: 19.942753509784144 , poiNumber: 2 , poiPromo: false , poiStatus: "Доступен" , title: "Театр Юлиуша Словацкого"),
            
            (poiCategory: "Культура", poiDescription: "Памятник культуры Малопольского воеводства. (1751 г.) Один из самых известных польских санктуариев. Имеет также наименование Скалка, что на польском языке означает «маленький камень». Рядом находится сторическое кладбище, где похоронены многие известные польские деятели культуры и искусства.",poiID: 8 , poiImage: image8, poiLat: 50.04875922916379 , poiLocation: "50.04875922916379, 19.937643674404907", poiLon: 19.937643674404907 , poiNumber: 3 , poiPromo: false , poiStatus: "Доступен" , title: "Костёл на Скалке"),
            
            (poiCategory: "Культура", poiDescription: "Исторический район, который был центром еврейской жизни в Кракове на протяжении веков. Сегодня здесь можно найти множество кафе, галерей и музеев.", poiID: 9, poiImage: image9, poiLat: 50.05180249673518 , poiLocation: "50.05180249673518, 19.945126804820717", poiLon: 19.945126804820717 , poiNumber: 4 , poiPromo: false , poiStatus: "Доступен" , title: "Казимеж (Еврейский квартал)"),
            
            (poiCategory: "Культура", poiDescription: "Этот музей расположен на территории бывшей фабрики Оскара Шиндлера и посвящен истории Кракова во время Второй мировой войны.", poiID: 10, poiImage: image10, poiLat: 50.047499162028906 , poiLocation: "50.047499162028906, 19.961754806770323", poiLon: 19.961754806770323 , poiNumber: 5 , poiPromo: false , poiStatus: "Доступен" , title: "Фабрика Шиндлера"),
            
            
            (poiCategory: "Природа", poiDescription: "Расположен в лесопарке Вольски, предлагает посетителям увидеть множество различных видов животных в приближенных к натуральным условиях.", poiID: 11, poiImage: image11 , poiLat: 50.055112243120604, poiLocation: "50.055112243120604, 19.854054303621297", poiLon: 19.854054303621297, poiNumber: 1 , poiPromo: false , poiStatus: "Доступен" , title: "Краковский зоопарк"),
            
            (poiCategory: "Природа", poiDescription: "Искусственный курган, созданный в 1820 году в память о национальном герое Польши Тадеуше Костюшко.", poiID: 12, poiImage: image12 , poiLat: 50.05496624021756, poiLocation: "50.05496624021756, 19.893337235525085", poiLon: 19.893337235525085, poiNumber: 2 , poiPromo: false , poiStatus: "Доступен" , title: "Курган Костюшко"),
            
            (poiCategory: "Природа", poiDescription: "Огромный луг почти в центре города. Прекрасное место для семейного и активного отдыха.", poiID: 13, poiImage: image13 , poiLat: 50.05970183469366, poiLocation: "50.05970183469366, 19.909546890212706", poiLon: 19.909546890212706, poiNumber: 3 , poiPromo: false , poiStatus: "Доступен" , title: "Блоня (Błonia)"),
            
            (poiCategory: "Природа", poiDescription: "Один из первых общественных парков в Европе, предлагает разнообразные развлечения и зоны отдыха для всех возрастов.", poiID: 14, poiImage: image14 , poiLat: 50.06247096459591, poiLocation: "50.06247096459591, 19.916071519618683", poiLon: 19.916071519618683, poiNumber: 4 , poiPromo: false , poiStatus: "Доступен" , title: "Парк Йордана"),
            
            (poiCategory: "Природа", poiDescription: "Прогулка вдоль набережной Вислы позволяет насладиться видами на город и спокойствием реки.", poiID: 15, poiImage: image15, poiLat: 50.05478501547104, poiLocation: "50.05478501547104, 19.928502374881113", poiLon: 19.928502374881113 , poiNumber: 5 , poiPromo: false , poiStatus: "Доступен" , title: "Река Висла")
        ]
        
        func addPOIs() {
            let context = persistentContainer.viewContext
            
            for poiData in pois {
                let poi = PointsOfInterest(context: context)
                poi.poiCategory = poiData.poiCategory
                poi.poiDescription = poiData.poiDescription
                poi.poiID = Int16(poiData.poiID)
                poi.poiImage = poiData.poiImage
                poi.poiLat = poiData.poiLat
                poi.poiLon = poiData.poiLon
                poi.poiNumber = Int16(poiData.poiNumber)
                poi.poiPromo = poiData.poiPromo
                poi.poiStatus = poiData.poiStatus
                poi.poiTitle = poiData.title
            }
            saveContext()
        }
        
        //MARK: Методы для работы с данными (добавление, извлечение, обновление, удаление)
        
        //    Получение списка челленджей
        func fetchAllChallenges() -> [Challenge] {
            let context = persistentContainer.viewContext
            let request = Challenge.fetchRequest() as! NSFetchRequest<Challenge> // Явное приведение типа
            do {
                return try context.fetch(request)
            } catch {
                print("Ошибка при загрузке челленджей: \(error)")
                return []
            }
        }
        
        
        //    Получение точек для конкретного челленджа
//        func fetchPointsOfInterest(for challenge: Challenge) -> [PointsOfInterest] {
//            let request: NSFetchRequest<PointsOfInterest> = PointsOfInterest.fetchRequest()
//            request.predicate = NSPredicate(format: "challenge == %@", challenge)
//
//            do {
//                return try context.fetch(request)
//            } catch {
//                print("Ошибка при загрузке точек интереса: \(error)")
//                return []
//            }
//        }
        
        //    Метод для изменения статуса челленджа на "активный"
        
        //    Отметка посещения точек интереса
        
    }
}
