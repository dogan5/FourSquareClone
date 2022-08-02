//
//  PlaceModel.swift
//  foursquareClone
//
//  Created by Doğan seçilmiş on 21.06.2022.
//

import Foundation
import UIKit

class PlaceModel {
    static let sharedInstance = PlaceModel()
    
    var placeName = ""
    var placeType = ""
    var placeatmosphere = ""
    var imageView = UIImage()
    var Placelatitude = ""
    var Placelongtitude = ""
    
    private init () {}
}
