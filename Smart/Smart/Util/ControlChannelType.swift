//
//  ControlChannelType.swift
//  Smart
//
//  Created by apple on 2018/6/19.
//  Copyright © 2018年 topgoal. All rights reserved.
//

import UIKit

// 控制通道
enum ControlChannelType: String {
    case fan
    case drencher
    case lamplight
    case trickleIrrigation = "trickle_irrigation"
    case sprayIrrigation = "spray_irrigation"
    case heatingSystem = "heating_system"
    case batchFeeder = "batch_feeder"
    case aeratorPump = "aerator_pump"
    case suctionPump = "suction_pump"
    case solenoidValve = "solenoid_valve"
    case flowValve = "flow_valve"
    case general
}

//extension ControlChannelType {
//    var color: UIColor {
//        }
//    }
//}
