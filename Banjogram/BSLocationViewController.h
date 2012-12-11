//
//  BSLocationViewController.h
//  Banjogram
//
//  Created by Brian Soule on 12/10/12.
//  Copyright (c) 2012 Soule. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "BSCoreLocationManager.h"


@interface BSLocationViewController : UITableViewController <BSCLControllerDelegate> {
    BSCoreLocationManager *locationManager;
}

- (void)locationUpdate:(CLLocation *)location;
- (void)locationError:(NSError *)error;

@end
