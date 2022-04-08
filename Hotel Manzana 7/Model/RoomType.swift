//
//  RoomType.swift
//  Hottel Manzana 7
//
//  Created by Navid on 1/30/22.
//

import Foundation


struct RoomType: Equatable {
    
    let name: String, shortName: String, id: Int, price: Int
    
    static func == (lhs: RoomType, rhs: RoomType) -> Bool {
        
        return lhs.id == rhs.id
        
    }
    
    static var all: [RoomType] {
        
        return [RoomType(name: "Two Queens", shortName: "2Q", id: 0, price: 179),
        RoomType(name: "One King", shortName: "K", id: 1, price: 209),
        RoomType(name: "Penthouse Suite", shortName: "PHS", id: 2, price: 309)
        ]
        
        
    }
    
}
