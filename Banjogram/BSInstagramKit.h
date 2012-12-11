//
//  BSInstagramKit.h
//  Banjogram
//
//  Created by Brian Soule on 12/10/12.
//  Copyright (c) 2012 Soule. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSInstagramKit : NSObject{
    NSString *lat;
    NSString *lng;
}

@property NSArray *instagramLocationSearchArray;
@property NSArray *instagramLocationMediaArray;
@property (nonatomic, assign) NSDictionary *chosenLocationDict;

+ (void)getInstagramLocations:(CLLocation *)location;
- (void)getInstagramLocationMedia:(CLLocation *)location;

+ (BSInstagramKit *)sharedInstance;

@end
