//
//  ViewController.m
//  Bluetooth-iOS
//
//  Created by Jhonathan Wyterlin on 10/07/15.
//  Copyright (c) 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "ViewController.h"

#import <CoreBluetooth/CoreBluetooth.h>

@interface ViewController ()<CBCentralManagerDelegate,CBPeripheralDelegate>

@property(nonatomic,strong) CBCentralManager *myCentralManager;

@end

@implementation ViewController

#pragma mark - View Lifecycle

-(void)viewDidLoad {
    
    [super viewDidLoad];
    
    // I use this to scan for peripherals
    self.myCentralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil options:nil];
    
    [self.myCentralManager scanForPeripheralsWithServices:nil options:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CBCentralManagerDelegate methods

-(void)centralManagerDidUpdateState:(CBCentralManager *)central {
    
    if ( central.state == CBCentralManagerStatePoweredOff ) {
        NSLog(@"PoweredOff");
    } else if ( central.state == CBCentralManagerStatePoweredOn ) {
        NSLog(@"PoweredOn");
    } else if ( central.state == CBCentralManagerStateResetting ) {
        NSLog(@"Resetting");
    } else if ( central.state == CBCentralManagerStateUnauthorized ) {
        NSLog(@"Unauthorized");
    } else if ( central.state == CBCentralManagerStateUnknown ) {
        NSLog(@"Unknown");
    } else if ( central.state == CBCentralManagerStateUnsupported ) {
        NSLog(@"Unsupported");
    }
    
}

-(void)centralManager:(CBCentralManager *)central
didDiscoverPeripheral:(CBPeripheral *)peripheral
    advertisementData:(NSDictionary *)advertisementData
                 RSSI:(NSNumber *)RSSI {
    
    NSLog( @"Discovered: %@", peripheral.name );
    
    [self stopScan];
    
    // Connecting to the discovered peripheral
    [self.myCentralManager connectPeripheral:peripheral options:nil];
    
}

-(void)centralManager:(CBCentralManager *)central
 didConnectPeripheral:(CBPeripheral *)peripheral {
    
    NSLog( @"Peripheral connected" );
    
    peripheral.delegate = self;
    
}

#pragma mark - Private methods

-(void)stopScan {
    
    [self.myCentralManager stopScan];
    
    NSLog(@"Scanning stopped");
    
}

@end
