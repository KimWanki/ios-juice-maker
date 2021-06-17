//
//  JuiceMaker - JuiceMaker.swift
//  Created by luyan. 
//  Copyright © yagom academy. All rights reserved.
//

import Foundation

let DidRecieveOrderMenuNotification: Notification.Name = Notification.Name("DidRecieveOrderMenu")

enum JuiceMenu: String {
    case strawberry = "딸기쥬스"
    case banana = "바나나쥬스"
    case kiwi = "키위쥬스"
    case fineapple = "파인애플쥬스"
    case strawberryBanana = "딸바쥬스"
    case mango = "망고쥬스"
    case mangoKiwi = "망키쥬스"
    
    var recipe: [HandlingFruit: Int] {
        switch self {
        case .strawberry:
            return [.strawberry: 16]
        case .banana:
            return [.banana: 10]
        case .kiwi:
            return [.kiwi: 3]
        case .fineapple:
            return [.fineapple: 2]
        case .strawberryBanana:
            return [.strawberry: 10, .banana: 1]
        case .mango:
            return [.mango: 3]
        case .mangoKiwi:
            return [.mango: 2, .kiwi: 1]
        }
    }
    
    func description() -> String {
        return self.rawValue
    }
}

struct JuiceMaker {
    private let store: FruitStore = FruitStore.shared
    
    func makeJuice(menu: JuiceMenu) throws {
        let ingredients: [HandlingFruit: Int] = menu.recipe
        try store.isAllIngredientEnough(ingredients: ingredients)
        store.useFruitToMakeJuice(ingredients: ingredients)
        NotificationCenter.default.post(name: DidRecieveOrderMenuNotification, object: nil, userInfo: ["menu": menu])
    }
}
