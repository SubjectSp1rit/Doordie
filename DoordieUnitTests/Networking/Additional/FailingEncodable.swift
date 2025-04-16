//
//  FailingEncodable.swift
//  DoordieUnitTests
//
//  Created by Arseniy on 10.04.2025.
//

import Foundation

struct FailingEncodable: Encodable {
    func encode(to encoder: Encoder) throws {
        throw NSError(domain: "TestDomain", code: 1, userInfo: nil)
    }
}
