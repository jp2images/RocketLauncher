//
//  AdafruitPeripheral.swift
//  RocketLauncher
//
//  Created by Jeff Patterson on 7/27/24.
//
// Services are used to break data up into logical entities, and contain
// specific chunks of data called characteristics. A service can have one or
// more characteristics, and each service distinguishes itself from other
// services by means of a unique numeric ID called a UUID, which can be either
// 16-bit (for official BLE Services) or 128-bit (for custom services).
// https://learn.adafruit.com/introduction-to-bluetooth-low-energy/gatt

import Foundation
import UIKit
import CoreBluetooth

class Feather_nRF52: NSObject{
    /// These UUIDs are 16 Bytes - 128 bit
    /// E.g., 0x2A37 =  16 bit, 2 Bytes and "b4250400-fb4b-4746-b2b0-93f0e61122c6" = 16 Bytes/128 bits
    public static let gpioServiceUUID = CBUUID.init(string: "b4250400-fb4b-4746-b2b0-93f0e61122c6")

    /// BLE Inputs to the MCU
    /// Launch the Rocket (Ignite the engine starter) This is the launch button on the mobile app
    public static let launchCharacteristicUUID = CBUUID.init(string: "b4250401-fb4b-4746-b2b0-93f0e61122c6")

    /// BLE Outputs from MCU
    /// Key switch in ON mode that indicate the Launch controller is ARMED and ready for the launch signal
    public static let enableSwitchCharacteristicUUID = CBUUID.init(string: "b4250403-fb4b-4746-b2b0-93f0e61122c6")
    
    /// Light on Launch controller for a visual queue that the unit is powered on and Ready
    public static let neoPixelLEDCharacteristicUUID = CBUUID.init(string: "b4250402-fb4b-4746-b2b0-93f0e61122c6")

    /// Battery level idicator of the MCU Launch controller
    public static let batteryLevelCharacteristicUUID = CBUUID.init(string: "b4250403-fb4b-4746-b2b0-93f0e61122c6")

    /// OPTIONAL IDEA: Audible sound from the Launch contoller counting down
    public static let beeperCharacteristicUUID = CBUUID.init(string: "b4250403-fb4b-4746-b2b0-93f0e61122c6")

}
