//
//  ApiSensor.swift
//  Wanaka Security
//
//  Created by Marcos Tirao on 16/11/2025.
//
import Foundation

enum ApiSensor: Api {
    
    case fetchAllZoneSensors(zone: UUID)
    
    var server: String {
        return "http://localhost:3000"
    }
    
    var path: String {
        switch self {
            case .fetchAllZoneSensors(zone: let zone):
            return "/api/wanaka/sensor/zone/\(zone)"
        }
    }
    
    var method: String {
        switch self {
        case .fetchAllZoneSensors:
            return "GET"
        }
    }
    
    var body: Data? {
        return nil
    }
    
    
}
