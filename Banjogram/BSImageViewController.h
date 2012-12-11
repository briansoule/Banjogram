//
//  BSImageViewController.h
//  Banjogram
//
//  Created by Brian Soule on 12/10/12.
//  Copyright (c) 2012 Soule. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+AFNetworking.h"
#import "AFHTTPClient.h"

@interface BSImageViewController : UIViewController{
    NSString *productName;
    CGFloat __scale;
    CGFloat __previousScale;
    CGFloat previousScale;
    CGFloat previousRotation;
    CGFloat beginX;
    CGFloat beginY;
}

@property IBOutlet UIImageView *imageView;
@property IBOutlet UIImage *image;
@property IBOutlet UILabel *name;
@property IBOutlet UITextView *captionTextView;
@property int chosenImage;
@property IBOutlet UIScrollView *scrollView;

@end
