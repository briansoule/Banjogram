//
//  BSImageViewController.m
//  Banjogram
//
//  Created by Brian Soule on 12/10/12.
//  Copyright (c) 2012 Soule. All rights reserved.
//

#import "BSImageViewController.h"
#import "BSInstagramKit.h"


@interface BSImageViewController ()

@end

@implementation BSImageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    _imageView.image = _image;
    
    NSArray *pics = [BSInstagramKit sharedInstance].instagramLocationMediaArray;
    NSString *imgUrl = [[[[pics objectAtIndex:self.chosenImage] objectForKey:@"images"] objectForKey:@"standard_resolution"] objectForKey:@"url"];

    @try {
            id captionText = [[[pics objectAtIndex:self.chosenImage] objectForKey:@"caption"] objectForKey:@"text"];
            
            if (captionText != nil && [captionText class] != [NSNull class]) {
                NSString *text = [[[pics objectAtIndex:self.chosenImage] objectForKey:@"caption"] objectForKey:@"text"];
                self.captionTextView.text = text;
            }
    }
    @catch (NSException *exception) {
        //caption remains blank
    }
    @finally {
        //caption remains blank
    }
    
    
    @try {
        if ([[[[pics objectAtIndex:self.chosenImage] objectForKey:@"caption"] objectForKey:@"from"] objectForKey:@"username"]) {
            NSString *username = [[[[pics objectAtIndex:self.chosenImage] objectForKey:@"caption"] objectForKey:@"from"] objectForKey:@"username"];
            self.name.text = username;
        }
    }
    @catch (NSException *exception) {
        //username remains blank
    }
    @finally {
        //username remains blank
    }


    
    
    NSString *imageToLoad = [NSString stringWithFormat:PLACEHOLDER_IMAGE];
    [_imageView setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:imageToLoad]];
    
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(scaleImage:)];
    [self.view addGestureRecognizer:pinchGesture];
    


    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveImage:)];
    [panGesture setMinimumNumberOfTouches:1];
    [panGesture setMaximumNumberOfTouches:1];
    [self.view addGestureRecognizer:panGesture];

}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
}


- (void)scaleImage:(UIPinchGestureRecognizer *)recognizer
{

    NSLog(@"gesture: %@",recognizer);
    if([recognizer state] == UIGestureRecognizerStateEnded) {
        previousScale = 1.0;
        return;
    }
    CGFloat newScale = 1.0 - (previousScale - [recognizer scale]);
    CGAffineTransform currentTransformation = self.imageView.transform;
    CGAffineTransform newTransform = CGAffineTransformScale(currentTransformation, newScale, newScale);
    self.imageView.transform = newTransform;
    previousScale = [recognizer scale];
    
}
//
- (void)moveImage:(UIPanGestureRecognizer *)recognizer
{
    CGPoint newCenter = [recognizer translationInView:self.view];
    if([recognizer state] == UIGestureRecognizerStateBegan) {
        beginX = self.imageView.center.x;
        beginY = self.imageView.center.y;
    }
    newCenter = CGPointMake(beginX + newCenter.x, beginY + newCenter.y);
    [self.imageView setCenter:newCenter];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
