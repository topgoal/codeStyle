//
//  GatherChannelType.swift
//  Smart
//
//  Created by apple on 2018/6/19.
//  Copyright © 2018年 topgoal. All rights reserved.
//

import UIKit

// 根据单位获取图标和颜色
enum GatherChannelType: String {
    case airTemperature = "air_temperature"
    case soilTemperature = "soil_temperature"
    case waterTemperature = "water_temperature"
    case airHumidity = "air_humidity"
    case soilMoisture = "soil_moisture"
    case moisture
    case ammonia
    case carbonDioxide = "carbon_dioxide"
    case illumination
    case windSpeed = "wind_speed"
    case hydrogenSulfide = "hydrogen_sulfide"
    case carbonMonoxide = "carbon_monoxide"
    case ozone
    case oxygen
    case methane
    case dissolvedOxygen = "dissolved_oxygen"
    case ph
    case temperatureDepthSalinity = "temperature_depth_salinity"
    case salinity
    case ammoniaNitrogen = "ammonia_nitrogen"
    case nitrite
    case soilEC = "soil_ec"
    case soilPH = "soil_ph"
    case pm25
    case noise
    case waterLevel = "water_level"
    case waterReserve = "water_reserve"
    case electricity
    case voltage
    case general
}


// 颜色
extension GatherChannelType {
    var color: UIColor {
        switch self {
        case .airTemperature:
            return .airTemperature
        case .soilTemperature:
            return .soilTemperature
        case .waterTemperature:
            return .waterTemperature
        case .airHumidity:
            return .airHumidity
        case .soilMoisture:
            return .soilMoisture
        case .moisture:
            return .moisture
        case .ammonia:
            return .ammonia
        case .carbonDioxide:
            return .carbonDioxide
        case .illumination:
            return .illumination
        case .windSpeed:
            return .windSpeed
        case .hydrogenSulfide:
            return .hydrogenSulfide
        case .carbonMonoxide:
            return .carbonMonoxide
        case .ozone:
            return .ozone
        case .oxygen:
            return .oxygen
        case .methane:
            return .methane
        case .dissolvedOxygen:
            return .dissolvedOxygen
        case .ph:
            return .ph
        case .temperatureDepthSalinity:
            return .temperatureDepthSalinity
        case .salinity:
            return .salinity
        case .ammoniaNitrogen:
            return .ammoniaNitrogen
        case .nitrite:
            return .nitrite
        case .soilEC:
            return .soilEC
        case .soilPH:
            return .soilPH
        case .pm25:
            return .pm25
        case .noise:
            return .noise
        case .waterLevel:
            return .waterLevel
        case .waterReserve:
            return .waterReserve
        case .electricity:
            return .electricity
        case .voltage:
            return .voltage
        case .general:
            return .general
        }
    }
}

// 采集通道/聚合通道(多个采集通道的组合): 17C+4D
//enum GatherChannelType: String {
//    case temperatureC1 = "C1"             // 温度，1°C
//    case humidityC2 = "C2"                // 湿度，1%
//    case ammoniaC3 = "C3"                 // 氨气，1ppm
//    case carbonD1 = "D1"                  // 二氧化碳 C4+C5，1ppm
//    case carbonC4 = "C4"                  // 二氧化碳 C4，低位，1ppm
//    case carbonC5 = "C5"                  // 二氧化碳 C5，高位，1ppm
//    case illuminationD2 = "D2"            // 光照 C6+C7，1lux
//    case illuminationC6 = "C6"            // 光照 C6，低位，1lux
//    case illuminationC7 = "C7"            // 光照 C7，高位，1lux
//    case windspeedC8 = "C8"               // 风速，0.1m/s
//    case sulfurC9 = "C9"                  // 硫化氢，1ppm
//    case dustD3 = "D3"                    // 粉尘，1ug/m3
//    case dustLowC10 = "C10"               // 粉尘 C10，低位，1ug/m3
//    case dustHightC11 = "C11"             // 粉尘 C11，高位，1ug/m3
//    case noiseC12 = "C12"                 // 噪音，1db
//    case temperatureC13 = "C13"           // 温度，1°C
//    case temperatureC14 = "C14"           // 温度，1°C
//    case temperatureC15 = "C15"           // 温度，1°C
//    case ammoniaD4 = "D4"                 // 氨气，1ppm
//    case ammoniaC16 = "C16"               // 氨气 C16，低位，1ppm
//    case ammoniaC17 = "C17"               // 氨气 C17，高位，1ppm
//}

//
//// 颜色
//extension GatherChannelType {
//    var color: UIColor {
//        switch self {
//        case .temperatureC1, .temperatureC13, .temperatureC14, .temperatureC15:
//            return UIColor.temperature
//        case .humidityC2:
//            return UIColor.humidity
//        case .ammoniaC3, .ammoniaD4, .ammoniaC16, .ammoniaC17:
//            return UIColor.ammonia
//        case .carbonD1, .carbonC4, .carbonC5:
//            return UIColor.carbon
//        case .illuminationD2, .illuminationC6, .illuminationC7:
//            return UIColor.illumination
//        case .windspeedC8:
//            return UIColor.windspeed
//        case .sulfurC9:
//            return UIColor.sulfur
//        case .dustD3, .dustLowC10, .dustHightC11:
//            return UIColor.dust
//        case .noiseC12:
//            return UIColor.noise
//        }
//    }
//}
//
//// 图片名称
//extension GatherChannelType {
//    var image: String {
//        switch self {
//        case .temperatureC1, .temperatureC13, .temperatureC14, .temperatureC15:
//            return "temperature"
//        case .humidityC2:
//            return "humidity"
//        case .ammoniaC3, .ammoniaD4, .ammoniaC16, .ammoniaC17:
//            return "ammonia"
//        case .carbonD1, .carbonC4, .carbonC5:
//            return "carbon"
//        case .illuminationD2, .illuminationC6, .illuminationC7:
//            return "illumination"
//        case .windspeedC8:
//            return "windspeed"
//        case .sulfurC9:
//            return "sulfur"
//        case .dustD3, .dustLowC10, .dustHightC11:
//            return "dust"
//        case .noiseC12:
//            return "noise"
//        }
//    }
//}

// 量程(min, max)
//extension GatherChannelType {
//    var range: (Float, Float) {
//        switch self {
//        case .temperatureC1, .temperatureC13, .temperatureC14, .temperatureC15:
//            return (min: -30, max: 125)
//        case .humidityC2:
//            return (min: 0, max: 100)
//        case .ammoniaC3:
//            return (min: 0, max: 100)
//        case .ammoniaD4:
//            return (min: 0, max: 500)
//        case .ammoniaC16:
//            return (min: 0, max: 200)
//        case .ammoniaC17:
//            return (min: 0, max: 200)
//        case .carbonD1:
//            return (min: 0, max: 5000)
//        case .carbonC4:
//            return (min: 0, max: 200)
//        case .carbonC5:
//            return (min: 0, max: 200)
//        case .illuminationD2:
//            return (min: 0, max: 65536)
//        case .illuminationC6:
//            return (min: 0, max: 200)
//        case .illuminationC7:
//            return (min: 0, max: 200)
//        case .windspeedC8:
//            return (min: 0, max: 20)
//        case .sulfurC9:
//            return (min: 0, max: 100)
//        case .dustD3:
//            return (min: 0, max: 1000)
//        case .dustHightC11:
//            return (min: 0, max: 200)
//        case .dustLowC10:
//            return (min: 0, max: 200)
//        case .noiseC12:
//            return (min: 0, max: 150)
//        }
//    }
//}
