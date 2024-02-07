////
////  DataManager.swift
////  Trip Challenge
////
////  Created by Kate on 24/01/2024.
////

import CoreLocation
import RealmSwift
import SwiftUI

class DatabaseManager {
    private var database: Realm

    init() {
        database = try! Realm()
        addPOIs()
        createAndAddChallenges()
        getTrendingChallenges()
        getAllPOIs()
        getAllChallenges()
    }
   
    // Получение популярных челленджей на основе рейтинга
    func getTrendingChallenges() -> [Challenge] {
        let challenges = database.objects(Challenge.self)
            .filter("challengeStatus == 'Доступен'")
            .sorted(byKeyPath: "challengeRating", ascending: false)
        return Array(challenges.prefix(5))
    }

    // Получение челленджей поблизости
    func getChallengesNear(location: CLLocation) -> [Challenge] {
        let allChallenges = database.objects(Challenge.self)
            .filter("challengeStatus == 'Доступен'")
           
        let sortedChallenges = allChallenges.sorted { challenge1, challenge2 -> Bool in
            let location1 = CLLocation(latitude: challenge1.challengeLat, longitude: challenge1.challengeLon)
            let location2 = CLLocation(latitude: challenge2.challengeLat, longitude: challenge2.challengeLon)
            return location1.distance(from: location) < location2.distance(from: location)
        }
        return Array(sortedChallenges)
    }
   
    /* В getTrendingChallenges челленджи сначала фильтруются по статусу (например, "Доступен"), затем сортируются по убыванию рейтинга, и выбираются первые пять.
     В getChallengesNear, челленджи сначала фильтруются по статусу. Затем используется кастомная сортировка, где каждый челлендж сравнивается по расстоянию от текущего местоположения пользователя. Возвращается массив, отсортированный от самого близкого к самому далекому.*/
    
    // MARK: POIs

    struct POIData {
        let poiCategory: String
        let poiDescription: String
        let poiID: Int
        let poiImage: Data
        let poiLat: Double
        let poiLocation: String
        let poiLon: Double
        let poiNumber: Int16
        let poiPromo: Bool
        let poiStatus: String
        let poiTitle: String
    }
    
    func addPOIs() {
        let existingPOIsCount = database.objects(POI.self).count
        if existingPOIsCount == 0 {
            guard let image1 = UIImage(named: "image1")?.jpegData(compressionQuality: 1.0),
                  let image2 = UIImage(named: "image2")?.jpegData(compressionQuality: 1.0),
                  let image3 = UIImage(named: "image3")?.jpegData(compressionQuality: 1.0),
                  let image4 = UIImage(named: "image4")?.jpegData(compressionQuality: 1.0),
                  let image5 = UIImage(named: "image5")?.jpegData(compressionQuality: 1.0),
                  let image6 = UIImage(named: "image6")?.jpegData(compressionQuality: 1.0),
                  let image7 = UIImage(named: "image7")?.jpegData(compressionQuality: 1.0),
                  let image8 = UIImage(named: "image8")?.jpegData(compressionQuality: 1.0),
                  let image9 = UIImage(named: "image9")?.jpegData(compressionQuality: 1.0),
                  let image10 = UIImage(named: "image10")?.jpegData(compressionQuality: 1.0),
                  let image11 = UIImage(named: "image11")?.jpegData(compressionQuality: 1.0),
                  let image12 = UIImage(named: "image12")?.jpegData(compressionQuality: 1.0),
                  let image13 = UIImage(named: "image13")?.jpegData(compressionQuality: 1.0),
                  let image14 = UIImage(named: "image14")?.jpegData(compressionQuality: 1.0),
                  let image15 = UIImage(named: "image15")?.jpegData(compressionQuality: 1.0)
            else {
                print("Не удалось загрузить изображение")
                return
            }
            
            let pois = [
                POIData(poiCategory: "Средневековье", poiDescription: "Представляет собой защитное сооружение, расположенное перед Старым городом. Один из немногих сохранившихся средневековых барбаканов в Европе.", poiID: 1, poiImage: image1, poiLat: 50.06556388793115, poiLocation: "50.06556388793115, 19.94162574007381", poiLon: 19.94162574007381, poiNumber: 1, poiPromo: false, poiStatus: "Доступен", poiTitle: "Барбакан"),
                
                POIData(poiCategory: "Средневековье", poiDescription: "Один из символов Кракова, известен своими внутренними убранствами и ежедневным зовом трубача, который звучит с одной из его башен.", poiID: 2, poiImage: image2, poiLat: 50.06167506873804, poiLocation: "50.06167506873804, 19.939269299798678", poiLon: 19.939269299798678, poiNumber: 2, poiPromo: false, poiStatus: "Доступен", poiTitle: "Мариацкий костел"),
                
                POIData(poiCategory: "Средневековье", poiDescription: "Сердце Старого города и одна из крупнейших средневековых площадей в Европе, окруженная историческими зданиями, торговыми рядами и кафе.", poiID: 3, poiImage: image3, poiLat: 50.06167506873804, poiLocation: "50.06167506873804, 19.939269299798678", poiLon: 19.939269299798678, poiNumber: 3, poiPromo: false, poiStatus: "Доступен", poiTitle: "Рыночная площадь (Rynek Główny)"),
                
                POIData(poiCategory: "Средневековье", poiDescription: "Богато украшенная католическая церковь в стиле барокко с еженедельными демонстрациями работы маятника Фуко.", poiID: 4, poiImage: image4, poiLat: 50.05711011810121, poiLocation: "50.05711011810121, 19.938570055043282", poiLon: 19.938570055043282, poiNumber: 4, poiPromo: false, poiStatus: "Доступен", poiTitle: "Костел святых Петра и Павла"),
                
                POIData(poiCategory: "Средневековье", poiDescription: "Символ польской государственности и культуры, древняя резиденция польских королей. Замок включает в себя ряд зданий, каждое из которых уникально по своему архитектурному стилю.", poiID: 5, poiImage: image5, poiLat: 50.05451062920299, poiLocation: "50.05451062920299, 19.93492129223292", poiLon: 19.93492129223292, poiNumber: 5, poiPromo: false, poiStatus: "Доступен", poiTitle: "Вавельский замок"),
                
                POIData(poiCategory: "Культура", poiDescription: "Содержит богатые коллекции польского искусства от средневековья до современности, включая известные произведения Яна Матейко.", poiID: 6, poiImage: image6, poiLat: 50.06065494915645, poiLocation: "50.06065494915645, 19.92361854069063", poiLon: 19.92361854069063, poiNumber: 1, poiPromo: false, poiStatus: "Доступен", poiTitle: "Национальный музей в Кракове"),
                
                POIData(poiCategory: "Культура", poiDescription: "Один из старейших и наиболее уважаемых театров в Польше, известен своей великолепной архитектурой и историей.", poiID: 7, poiImage: image7, poiLat: 50.06403848711694, poiLocation: "50.06403848711694, 19.942753509784144", poiLon: 19.942753509784144, poiNumber: 2, poiPromo: false, poiStatus: "Доступен", poiTitle: "Театр Юлиуша Словацкого"),
                
                POIData(poiCategory: "Культура", poiDescription: "Памятник культуры Малопольского воеводства. (1751 г.) Один из самых известных польских санктуариев. Имеет также наименование Скалка, что на польском языке означает «маленький камень». Рядом находится сторическое кладбище, где похоронены многие известные польские деятели культуры и искусства.", poiID: 8, poiImage: image8, poiLat: 50.04875922916379, poiLocation: "50.04875922916379, 19.937643674404907", poiLon: 19.937643674404907, poiNumber: 3, poiPromo: false, poiStatus: "Доступен", poiTitle: "Костёл на Скалке"),
                
                POIData(poiCategory: "Культура", poiDescription: "Исторический район, который был центром еврейской жизни в Кракове на протяжении веков. Сегодня здесь можно найти множество кафе, галерей и музеев.", poiID: 9, poiImage: image9, poiLat: 50.05180249673518, poiLocation: "50.05180249673518, 19.945126804820717", poiLon: 19.945126804820717, poiNumber: 4, poiPromo: false, poiStatus: "Доступен", poiTitle: "Казимеж (Еврейский квартал)"),
                
                POIData(poiCategory: "Культура", poiDescription: "Этот музей расположен на территории бывшей фабрики Оскара Шиндлера и посвящен истории Кракова во время Второй мировой войны.", poiID: 10, poiImage: image10, poiLat: 50.047499162028906, poiLocation: "50.047499162028906, 19.961754806770323", poiLon: 19.961754806770323, poiNumber: 5, poiPromo: false, poiStatus: "Доступен", poiTitle: "Фабрика Шиндлера"),
                
                POIData(poiCategory: "Природа", poiDescription: "Расположен в лесопарке Вольски, предлагает посетителям увидеть множество различных видов животных в приближенных к натуральным условиях.", poiID: 11, poiImage: image11, poiLat: 50.055112243120604, poiLocation: "50.055112243120604, 19.854054303621297", poiLon: 19.854054303621297, poiNumber: 1, poiPromo: false, poiStatus: "Доступен", poiTitle: "Краковский зоопарк"),
                
                POIData(poiCategory: "Природа", poiDescription: "Искусственный курган, созданный в 1820 году в память о национальном герое Польши Тадеуше Костюшко.", poiID: 12, poiImage: image12, poiLat: 50.05496624021756, poiLocation: "50.05496624021756, 19.893337235525085", poiLon: 19.893337235525085, poiNumber: 2, poiPromo: false, poiStatus: "Доступен", poiTitle: "Курган Костюшко"),
                
                POIData(poiCategory: "Природа", poiDescription: "Огромный луг почти в центре города. Прекрасное место для семейного и активного отдыха.", poiID: 13, poiImage: image13, poiLat: 50.05970183469366, poiLocation: "50.05970183469366, 19.909546890212706", poiLon: 19.909546890212706, poiNumber: 3, poiPromo: false, poiStatus: "Доступен", poiTitle: "Блоня (Błonia)"),
                
                POIData(poiCategory: "Природа", poiDescription: "Один из первых общественных парков в Европе, предлагает разнообразные развлечения и зоны отдыха для всех возрастов.", poiID: 14, poiImage: image14, poiLat: 50.06247096459591, poiLocation: "50.06247096459591, 19.916071519618683", poiLon: 19.916071519618683, poiNumber: 4, poiPromo: false, poiStatus: "Доступен", poiTitle: "Парк Йордана"),
                
                POIData(poiCategory: "Природа", poiDescription: "Прогулка вдоль набережной Вислы позволяет насладиться видами на город и спокойствием реки.", poiID: 15, poiImage: image15, poiLat: 50.05478501547104, poiLocation: "50.05478501547104, 19.928502374881113", poiLon: 19.928502374881113, poiNumber: 5, poiPromo: false, poiStatus: "Доступен", poiTitle: "Река Висла")
            ]
            
            try? database.write {
                for poi in pois {
                    let newPOI = POI()
                    newPOI.poiCategory = poi.poiCategory
                    newPOI.poiDescription = poi.poiDescription
                    newPOI.poiID = poi.poiID
                    newPOI.poiImage = poi.poiImage
                    newPOI.poiLat = poi.poiLat
                    newPOI.poiLocation = poi.poiLocation
                    newPOI.poiLon = poi.poiLon
                    newPOI.poiNumber = poi.poiNumber
                    newPOI.poiPromo = poi.poiPromo
                    newPOI.poiStatus = poi.poiStatus
                    newPOI.poiTitle = poi.poiTitle
                    database.add(newPOI)
                }
            }
        }
    }
    // Функция для извлечения всех POI
    func getAllPOIs() -> Results<POI> {
        return database.objects(POI.self)
    }

    // Функция для обновления POI
    func updatePOI(poiID: String, newPOIData: POIData) {
        if let poiToUpdate = database.objects(POI.self).filter("poiID == %@", poiID).first {
            try! database.write {
                poiToUpdate.poiCategory = newPOIData.poiCategory
                poiToUpdate.poiDescription = newPOIData.poiDescription
            }
        }
    }

    // Функция для удаления POI
    func deletePOI(poiID: String) {
        if let poiToDelete = database.objects(POI.self).filter("poiID == %@", poiID).first {
            try! database.write {
                database.delete(poiToDelete)
            }
        }
    }
    
    // MARK: Challenges
    
    struct ChallengeData {
        let challengeID: Int16
        let challengeTitle: String
        let challengeDescription: String
        let challengeImage: Data
        let challengeCategory: String
        let challengeLat: Double
        let challengeLon: Double
        let challengeNumberOfPoints: Int32
        let challengeRating: Double
        let challengeStatus: String
    }

    func addChallenge(challengeData: ChallengeData) {
        let newChallenge = Challenge()
        
        let pois = database.objects(POI.self).filter("poiCategory == %@", challengeData.challengeCategory)
        for poi in pois.prefix(Int(challengeData.challengeNumberOfPoints)) {
            newChallenge.pointsOfInterest.append(poi)
        }

        try! database.write {
            database.add(newChallenge)
        }
    }
}

extension DatabaseManager {
    // Функция для добавления челленджа
    
    func createAndAddChallenges() {
        let existingChallengesCount = database.objects(Challenge.self).count
        if existingChallengesCount == 0 {
            guard let image16 = UIImage(named: "image16")?.jpegData(compressionQuality: 1.0),
                  let image17 = UIImage(named: "image17")?.jpegData(compressionQuality: 1.0)
            else {
                print("Не удалось загрузить изображение")
                return
            }
            
            let challengesData = [
                ChallengeData(challengeID: 1, challengeTitle: "Королевский Краков", challengeDescription: "Прогуляйтесь по Королевской дороге от самого знаменитого костела Кракова до древней резиденции Польских королей", challengeImage: image16, challengeCategory: "Средневековье", challengeLat: 50.06556388793115, challengeLon: 19.94162574007381, challengeNumberOfPoints: 5, challengeRating: 5.0, challengeStatus: "Доступен"),
                ChallengeData(challengeID: 2, challengeTitle: "Ценителям культуры", challengeDescription: "Проведите незабываемый день окунувшись в культурную жизнь города!", challengeImage: image16, challengeCategory: "Культура", challengeLat: 50.06167506873804, challengeLon: 19.939269299798678, challengeNumberOfPoints: 5, challengeRating: 5.0, challengeStatus: "Доступен"),
                ChallengeData(challengeID: 3, challengeTitle: "Отдыхаем на природе", challengeDescription: "Начнем с активного отдыха в зоопарке и продвинемся к любимым паркам горожан. В завершении полюбуемся городом с берега Вислы.", challengeImage: image17, challengeCategory: "Природа", challengeLat: 50.055112243120604, challengeLon: 19.854054303621297, challengeNumberOfPoints: 5, challengeRating: 5.0, challengeStatus: "Доступен")
            ]
            
            for challengeData in challengesData {
                        let newChallenge = Challenge()
                
                let pois = database.objects(POI.self).filter("poiCategory == %@", challengeData.challengeCategory)
                            for poi in pois.prefix(Int(challengeData.challengeNumberOfPoints)) {
                                newChallenge.pointsOfInterest.append(poi)
                            }
                            
                            try? database.write {
                                database.add(newChallenge)
                            }
            }
        }
    }
    // Функция для извлечения всех челленджей
    func getAllChallenges() -> Results<Challenge> {
        return database.objects(Challenge.self)
    }

    // Функция для обновления челленджа
    func updateChallenge(challengeID: String, newChallengeData: ChallengeData) {
        if let challengeToUpdate = database.objects(Challenge.self).filter("challengeID == %@", challengeID).first {
            try! database.write {
                challengeToUpdate.challengeTitle = newChallengeData.challengeTitle
                challengeToUpdate.challengeDescription = newChallengeData.challengeDescription
                // Обновите другие поля по необходимости
            }
        }
    }

    // Функция для удаления челленджа
    func deleteChallenge(challengeID: String) {
        if let challengeToDelete = database.objects(Challenge.self).filter("challengeID == %@", challengeID).first {
            try! database.write {
                database.delete(challengeToDelete)
            }
        }
    }
}

//Migration Handling: The code does not currently handle database migrations. As  data model evolves,  will be need to manage schema versions and provide migration blocks to update existing data to the new schema without losing data.
