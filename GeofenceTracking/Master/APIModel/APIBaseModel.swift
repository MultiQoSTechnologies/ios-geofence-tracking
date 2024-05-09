//
//  RootClass.swift
//  Model Generated using http://www.jsoncafe.com/ 

import Foundation

struct APIBaseModel<T,M> : Codable where T : Codable, M : Codable {
    
    let data : T?
    var meta : M?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case meta = "meta"
    } 
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(T.self, forKey: .data)
        meta = try values.decodeIfPresent(M.self, forKey: .meta)
        if meta == nil{
            meta = try MDLMeta(from: decoder) as? M//try decoder.container(keyedBy: CodingKeysError.self) as? M//CodingKeysError.self)
        }
    }
    
}

struct APIBaseModelWithMeta<M> : Codable where M : Codable {
    
    var meta : M?
    
    enum CodingKeys: String, CodingKey {
        case meta = "meta"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        meta = try values.decodeIfPresent(M.self, forKey: .meta)
        if meta == nil{
            meta = try MDLMeta(from: decoder) as? M//try decoder.container(keyedBy: CodingKeysError.self) as? M//CodingKeysError.self)
        }
    }
    
}

struct APIBaseArrayModel<T,M> : Codable where T : Codable, M : Codable {
    
    let data : [T]?
    var meta : M?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case meta = "meta"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([T].self, forKey: .data)
        meta = try values.decodeIfPresent(M.self, forKey: .meta)
        if meta == nil{
            meta = try MDLMeta(from: decoder) as? M//try decoder.container(keyedBy: CodingKeysError.self) as? M//CodingKeysError.self)
        }
    }
    
}

extension Collection {
    
    func parseResponse<T: Encodable>() -> T? where T: Decodable {
        
        func parseData<T: Encodable,M:Collection>(response:M) -> T? where T: Decodable {
            do {
                return try response.toData().decoded()
            } catch {
                AppLogs.debugPrint(error)
                return nil
            }
        }
        return parseData(response: self)
    }
}
