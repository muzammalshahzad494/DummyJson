//
//  SingleUser.swift
//  DummyJSON
//
//  Created by Muzammal Shahzad on 6/23/23.
//

import Foundation

// MARK: - SingleUser
struct SingleUser: Codable {
    let id: Int
    let firstName, lastName, maidenName: String
    let age: Int
    let gender, email, phone, username: String
    let password, birthDate: String
    let image: String
    let bloodGroup: String
    let height: Int
    let weight: Double
    let eyeColor: String
    let hair: Hair
    let domain, ip: String
    let address: Address
    let macAddress, university: String
    let bank: Bank
    let company: Company
    let ein, ssn, userAgent: String
}
