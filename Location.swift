//
//  Location.swift
//  roam
//
//  Created by user266918 on 12/5/24.
//

import Foundation
import FirebaseFirestore

struct Location: Codable{
    @DocumentID var id: String?
    var name: String
    
    init(name: String) {
        self.name = name
    }
}
