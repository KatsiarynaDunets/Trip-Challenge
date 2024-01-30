//
//  Promo.swift
//  Trip Challenge
//
//  Created by Kate on 04/12/2023.
//

import Foundation
import CoreData

struct Promo {
    let title: String
    let description: String
    let discount: String
    let activeUntil: Date
/*In this Promo struct:
    
    title is a String that represents the title of the promo.
    description is a String that provides details about the promo.
    discount is a String that indicates the discount offered. You can change the type to a numeric type like Double or Int if you prefer to handle discounts as numbers.
    activeUntil is a Date that specifies until when the promo is valid.
    isActive() is a helper method to quickly check if the promo is still active based on the current date.
    */
    // Initialize a Promo object
    
    
    init(title: String, description: String, discount: String, activeUntil: Date) {
        self.title = title
        self.description = description
        self.discount = discount
        self.activeUntil = activeUntil
    }

    // A helper function to check if the promo is currently active
    func isActive() -> Bool {
        return Date() <= activeUntil
    }
}
