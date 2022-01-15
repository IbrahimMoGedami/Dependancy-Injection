//
//  Services.swift
//  dependancyInjection
//
//  Created by Ebrahim  Mo Gedamy on 4/1/20.
//  Copyright © 2020 Ebrahim  Mo Gedamy. All rights reserved.
//

import Foundation

class Services {
    
    private init(){ }
    static let shared = Services()
    
    func doStuff() {
        print("Did stuff")
    }
}
