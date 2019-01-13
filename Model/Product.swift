//
//  Product.swift
//  CoreDataRx
//
//  Created by Rogerio de Paula Assis on 1/11/19.
//  Copyright © 2019 Rogerio de Paula Assis. All rights reserved.
//

import Foundation
import CoreData

public struct Product: Codable {
    public let uuid: String
    public let title: String

    public init(uuid: String, title: String) {
        self.uuid = uuid
        self.title = title
    }
}
