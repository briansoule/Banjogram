//
//  BSInstagramKit.m
//  Banjogram
//
//  Created by Brian Soule on 12/10/12.
//  Copyright (c) 2012 Soule. All rights reserved.
//

#import "BSInstagramKit.h"
#import "Constants.h"

@implementation BSInstagramKit

+ (BSInstagramKit *)sharedInstance
{
    static BSInstagramKit *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[BSInstagramKit alloc] init];
        // Do any other initialisation stuff here
    });
    return sharedInstance;
}

+ (void)getInstagramLocations:(CLLocation *)location{
    
    dispatch_queue_t myQueue;
    myQueue = dispatch_queue_create("com.soulemobile.networking.instagram", NULL);
    dispatch_async(myQueue, ^ {

        NSString *getUrlString = [INSTAGRAM_SEARCH stringByAppendingString:[NSString stringWithFormat:@"?lat=%f&lng=%f&access_token=%@", location.coordinate.latitude, location.coordinate.longitude, INSTAGRAM_ACCESS_TOKEN]];
        NSURL *url = [NSURL URLWithString:getUrlString]; 
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"GET"];

        NSURLResponse *response = NULL;
        NSError *requestError = NULL;
        NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&requestError];
        
        NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        NSLog(@"responseString: %@",responseString);
        
        
        NSDictionary* jsonDict;
        if (responseData) {
            jsonDict = [NSJSONSerialization
                        JSONObjectWithData:responseData //1
                        options:kNilOptions
                        error:&requestError];
            
            NSArray *instagramData = [jsonDict objectForKey:@"data"];
            
            [BSInstagramKit sharedInstance].instagramLocationSearchArray = instagramData;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter]
                 postNotificationName:@"ApplyLocationSearchData"
                 object:self];
            });

            
        }
        else {
            //More error handling
        }
        
        
    });
    
}

- (void)getInstagramLocationMedia:(CLLocation *)location{
    
    lng = [[BSInstagramKit sharedInstance].chosenLocationDict objectForKey:@"longitude"];
    lat = [[BSInstagramKit sharedInstance].chosenLocationDict objectForKey:@"latitude"];
    
    dispatch_queue_t myQueue;
    myQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(myQueue, ^ {
        
        NSLog(@"chosen lat long: %@,%@", lat, lng);
        
        NSString *getUrlString = [INSTAGRAM_LOCATION_MEDIA stringByAppendingString:[NSString stringWithFormat:@"?lat=%@&lng=%@&access_token=%@", lat, lng, INSTAGRAM_ACCESS_TOKEN]];
        NSURL *url = [NSURL URLWithString:getUrlString];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"GET"];

        NSURLResponse *response = NULL;
        NSError *requestError = NULL;
        NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&requestError];
        
        NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        NSLog(@"responseString: %@",responseString);
        
        
        NSDictionary* jsonDict;
        if (responseData) {
            jsonDict = [NSJSONSerialization
                        JSONObjectWithData:responseData //1
                        options:kNilOptions
                        error:&requestError];
            
            NSArray *instagramData = [jsonDict objectForKey:@"data"];
            
            [BSInstagramKit sharedInstance].instagramLocationMediaArray = instagramData;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter]
                 postNotificationName:@"ApplyMediaSearchData"
                 object:self];
            });
            
        }
        else {
            //error handling
        }
        
        
        
    });
    
}


@end
