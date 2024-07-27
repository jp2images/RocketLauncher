//
//  AdafruitPeripheral.swift
//  RocketLauncher
//
//  Created by Jeff Patterson on 7/27/24.
//

import Foundation
import UIKit
import CoreBluetooth

class Feather_nRF52: NSObject{
    
    public static let gpioServiceUUID                 = CBUUID.init(string: "b4250400-fb4b-4746-b2b0-93f0e61122c6")
    public static let enableSwitchCharacteristicUUID  = CBUUID.init(string: "b4250403-fb4b-4746-b2b0-93f0e61122c6")
    public static let launchCharacteristicUUID        = CBUUID.init(string: "b4250401-fb4b-4746-b2b0-93f0e61122c6")
    public static let neoPixelLEDCharacteristicUUID   = CBUUID.init(string: "b4250402-fb4b-4746-b2b0-93f0e61122c6")
    public static let batteryLevelCharacteristicUUID  = CBUUID.init(string: "b4250403-fb4b-4746-b2b0-93f0e61122c6")
}
