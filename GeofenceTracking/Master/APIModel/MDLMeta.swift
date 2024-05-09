//
//  Meta.swift
//  Model Generated using http://www.jsoncafe.com/ 

import Foundation

enum MetaStatus: Int {
    case success = 1
    case failed = 0
}

struct MDLMeta : Codable {
    
    let message : String?
    let token : String?
    private let _status : Int?
    private let is_vendor : Bool?
    let isVerifyUser: Bool?
    let totalCount: Int?
    let totalCartCount: Int?
    let timestamp: String?
    let maxMessage: String?
    let isBidEnd: Bool?
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case _status = "status"
        case token = "token"
        case is_vendor = "isVendor"
        case isVerifyUser = "isVerified"
        case totalCount = "totalCount"
        case totalCartCount = "totalCartCount"
        case timestamp = "timestamp"
        case maxMessage = "maxMessage"
        case isBidEnd = "isBidEnd"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        token = try values.decodeIfPresent(String.self, forKey: .token)
        _status = try values.decodeIfPresent(Int.self, forKey: ._status)
        is_vendor = try values.decodeIfPresent(Bool.self, forKey: .is_vendor)
        isVerifyUser = try values.decodeIfPresent(Bool.self, forKey: .isVerifyUser)
        totalCount = try values.decodeIfPresent(Int.self, forKey: .totalCount)
        totalCartCount = try values.decodeIfPresent(Int.self, forKey: .totalCartCount)
        timestamp = try values.decodeIfPresent(String.self, forKey: .timestamp)
        maxMessage = try values.decodeIfPresent(String.self, forKey: .maxMessage)
        isBidEnd = try values.decodeIfPresent(Bool.self, forKey: .isBidEnd)
    }
    
    var status: MetaStatus {
        return MetaStatus(rawValue: _status ?? 0) ?? .failed
    }
}
