//
//  BSCoreLocationManager.h
//  Banjogram
//
//  Created by Brian Soule on 12/10/12.
//  Copyright (c) 2012 Soule. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BSCLControllerDelegate
@required
- (void)locationUpdate:(CLLocation *)location;
- (void)locationError:(NSError *)error;
@end

@interface BSCoreLocationManager : NSObject <CLLocationManagerDelegate> {
    CLLocationManager *locationManager;
    id delegate;
}

@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, assign) id  delegate;
@property (atomic, assign) CLLocation *currentLocation;

+ (BSCoreLocationManager *)sharedInstance;

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation;

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error;

@end
