//
//  Promo.swift
//  Trip Challenge
//
//  Created by Kate on 04/12/2023.
//

import Foundation

struct Promo {
    let title: String // Заголовок промоакции
    let description: String // Описание промоакции
    let discount: String // Скидка промоакции
    let activeUntil: Date // Дата окончания активности промоакции
    let imageName: String? // Название изображения (опционально)

    // Инициализация объекта Promo
    init(title: String, description: String, discount: String, activeUntil: Date, imageName: String? = nil) {
        self.title = title
        self.description = description
        self.discount = discount
        self.activeUntil = activeUntil
        self.imageName = imageName
    }

    // Вспомогательная функция для проверки активности промоакции
    func isActive() -> Bool {
        return Date() <= activeUntil
    }
}
