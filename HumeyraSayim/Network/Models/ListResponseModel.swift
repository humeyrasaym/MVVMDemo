//
//  ListResponseModel.swift
//  HumeyraSayim
//
//  Created by Hümeyra SAYIM on 2/2/25.
//

import Foundation


struct ListResponseModel: Codable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: AdressData?
    let phone: String
    let website: String
    let company: CompanyData?
    
}

//MARK: - Address Data
struct AdressData: Codable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: GeoData?
}

//MARK: - Geo Data
struct GeoData: Codable {
    let lat: String
    let lng: String
}

//MARK: - Company Data
struct CompanyData: Codable {
    let name: String
    let catchPhrase: String
    let bs: String
}
