//
//  Codable.swift
//  FlickrWalker
//
//  Created by Antonio Zdelican on 29.11.21.
//

import Foundation

extension Encodable {
    var jsonObject: [String: Any]? {
        return try? JSONEncoder().encodeJSONObject(self) as? [String: Any]
    }
}

extension JSONEncoder {
    func encodeJSONObject<T: Encodable>(_ value: T, options opt: JSONSerialization.ReadingOptions = []) throws -> Any {
        let data = try encode(value)
        return try JSONSerialization.jsonObject(with: data, options: opt)
    }
}

extension JSONDecoder {
    func decode<T: Decodable>(_: T.Type, withJSONObject object: Any, options opt: JSONSerialization.WritingOptions = []) throws -> T {
        let data = try JSONSerialization.data(withJSONObject: object, options: opt)
        return try decode(T.self, from: data)
    }
}
