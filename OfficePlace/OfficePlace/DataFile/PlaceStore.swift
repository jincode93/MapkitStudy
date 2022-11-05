//
//  PlaceStore.swift
//  OfficePlace
//
//  Created by 진준호 on 2022/11/05.
//

import Foundation
import Combine

class PlaceStore: ObservableObject {
    @Published var places: [Place]
    
    init (places: [Place] = []) {
        self.places = places
    }
}
