//
//  BeerDataModel.swift
//  MusicPlayer_cred
//
//  Created by Siddhant Mishra on 30/10/19
//  Copyright © 2019 Siddhant Mishra. All rights reserved.
//

import Foundation
import ObjectMapper

typealias Song = SongsData

struct SongsData: Mappable {

    public var song: String?
    public var url: String?
    public var artists: String?
    public var cover_image: String?
    public var isSelected = false
    
    init?(map: Map) {

    }

    init?() {

    }

    mutating func mapping(map: Map) {
        song <- map["song"]
        url <- map["url"]
        artists <- map["artists"]
        cover_image <- map["cover_image"]
    }

}
