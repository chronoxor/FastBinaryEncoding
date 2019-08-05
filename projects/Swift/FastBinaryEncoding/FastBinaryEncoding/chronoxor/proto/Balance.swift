//
//  Balance.swift
//  fbe-example
//
//  Created by Andrey on 8/2/19.
//  Copyright © 2019 Andrey. All rights reserved.
//

import Foundation

class Balance {
    var currency: String = ""
    var amount: Double = 0.0
    
    init(currency: String = "", amount: Double = 0.0) {
        self.currency = currency
        self.amount = amount
    }
    
    func hashCode() -> Int {
        var hash = 17
        hash = hash * 31 + currency.hashValue
        return hash
    }
    
}
