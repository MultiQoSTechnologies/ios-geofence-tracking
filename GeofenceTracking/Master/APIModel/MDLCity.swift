//
//  MDLCity.swift
//  SetupApp
//
//  Created by MultiQoS on 05/04/2021.
//  Copyright © 2021 MultiQoS. All rights reserved.
//

import UIKit


struct MDLCountryList: Codable {
    
    let countryId: Int?
    let name: String?
    let iso: String?
    let phonePrefix: String?
    
    enum CodingKeys: String, CodingKey {
        
        case countryId = "country_id"
        case name = "name"
        case iso = "iso"
        case phonePrefix = "phone_prefix"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        countryId = try values.decodeIfPresent(Int.self, forKey: .countryId)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        iso = try values.decodeIfPresent(String.self, forKey: .iso)
        phonePrefix = try values.decodeIfPresent(String.self, forKey: .phonePrefix)
    }
}
