//
//  Sensor.swift
//  Wanaka Security
//
//  Created by Marcos Tirao on 16/11/2025.
//

import Foundation

enum SensorType: String, Codable {
    case Door = "DOOR"
    case Window = "WINDOW"
    case Motion = "MOTION"
    case Smoke = "SMOKE"
}

enum SensorStatus: String, Codable {
    case Active = "ACTIVE"
    case Inactive = "INACTIVE"
    case Triggered = "TRIGGERED"
    case Malfunctioning = "MALFUNCTIONING"
}

struct Sensor: Codable, Identifiable  {
    let id: UUID
    let type: SensorType
    let status: SensorStatus
    let localtion: String
}
