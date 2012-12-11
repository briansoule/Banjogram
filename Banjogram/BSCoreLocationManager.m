//
//  BSCoreLocationManager.m
//  Banjogram
//
//  Created by Brian Soule on 12/10/12.
//  Copyright (c) 2012 Soule. All rights reserved.
//

#import "BSCoreLocationManager.h"

@implementation BSCoreLocationManager

+ (BSCoreLocationManager *)sharedInstance
{
    static BSCoreLocationManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[BSCoreLocationManager alloc] init];
        // Do any other initialisation stuff here
    });
    return sharedInstance;
}

- (id) init {
    self = [super init];
    if (self != nil) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self; // send loc updates to myself
    }
    return self;
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"Location: %@", [newLocation description]);
    [BSCoreLocationManager sharedInstance].currentLocation = newLocation;
    [self.delegate locationUpdate:newLocation];
}


- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
	NSLog(@"Error: %@", [error description]);
    [self.delegate locationError:error];
}


@end
