//
//  Place.swift
//  OfficePlace
//
//  Created by 진준호 on 2022/11/05.
//

import Foundation

struct Place: Codable, Identifiable {
    var id: String
    var name: String
    var imageUrl: String
    var siteUrl: String
    
    var lat: Double
    var long: Double
}
