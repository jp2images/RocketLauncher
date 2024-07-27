//
//  ViewController.swift
//  RocketLauncher
//
//  Created by Jeff Patterson on 7/27/24.
//

import Foundation
import UIKit

import CoreBluetooth

class ViewController: UIViewController, CBPeripheralDelegate, CBCentralManagerDelegate{
    
    // Properties
    private var centralManager: CBCentralManager!
    private var peripheral: CBPeripheral!
    
    override func viewDidLoad() {
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    /// Start scanning when the application starts up (powers on)
    func centralManagerDidUpdateState(_ central: CBCentralManager){
        print("BLE Central state update")
        if central.state != .poweredOn {
            print("BLE Central is not powered on")
        } else{
            print("BLE Central is scanning for \(Feather_nRF52.gpioServiceUUID)")
            centralManager.scanForPeripherals(withServices: [Feather_nRF52.gpioServiceUUID],
                                              options: [CBCentralManagerScanOptionAllowDuplicatesKey: true])
        }
    }
    
    /// Get the scan reult
    /// This event will run when a device is found
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber){
        
        /// Found the Feather board
        self.centralManager.stopScan()
        
        /// Get the peripheral instance
        self.peripheral = peripheral
        self.peripheral.delegate = self
        
        /// Connect
        self.centralManager.connect(self.peripheral, options: nil)
    }
    
    /// If we can connect this will run
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral){
        if peripheral == self.peripheral {
            print("Connected to the Feather")
            peripheral.discoverServices([Feather_nRF52.gpioServiceUUID])
        }
    }
    
    /// When discovery is complete we need to make sure that we conected to the correct device
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?){
        if let services = peripheral.services {
            for service in services {
                if service.uuid == Feather_nRF52.gpioServiceUUID {
                    /// Start discovery characteristics
                    peripheral.discoverCharacteristics([Feather_nRF52.enableSwitchCharacteristicUUID,
                                                        Feather_nRF52.launchCharacteristicUUID,
                                                        Feather_nRF52.batteryLevelCharacteristicUUID,
                                                        Feather_nRF52.neoPixelLEDCharacteristicUUID], for: service)
                    return
                }
            }
        }
    }
    
    
    /// Indicate all of the discovery of characteristics are complete
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        if let characteristics = service.characteristics {
            for characteristic in characteristics {
                if characteristic.uuid == Feather_nRF52.enableSwitchCharacteristicUUID {
                    print("Enable Switch characteristic found")
                } else if characteristic.uuid == Feather_nRF52.launchCharacteristicUUID {
                    print("Launch Relay output characteristic found")
                } else if characteristic.uuid == Feather_nRF52.batteryLevelCharacteristicUUID {
                    print("Battery Level characteristic found");
                } else if characteristic.uuid == Feather_nRF52.neoPixelLEDCharacteristicUUID {
                    print("Neopixel characteristic found");
                }
            }
        }
    }
    
    
}
