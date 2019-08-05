//
//  ReceiverListener.swift
//  fbe-example
//
//  Created by Andrey on 8/5/19.
//  Copyright © 2019 Andrey. All rights reserved.
//

import Foundation

protocol ReceiverListener {
    func onReceive(value: Balance)
}

extension ReceiverListener {
    func onReceive(value: Balance) { }
}
