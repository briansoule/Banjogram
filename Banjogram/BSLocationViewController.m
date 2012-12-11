//
//  BSLocationViewController.m
//  Banjogram
//
//  Created by Brian Soule on 12/10/12.
//  Copyright (c) 2012 Soule. All rights reserved.
//

#import "BSLocationViewController.h"
#import "BSLocationCell.h"
#import "BSInstagramKit.h"
#import "BSImageViewController.h"
#import "BSInstagramMediaViewController.h"


@interface BSLocationViewController ()

@end

@implementation BSLocationViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applyData:)
                                                 name:@"ApplyLocationSearchData"
                                               object:nil];

    locationManager = [[BSCoreLocationManager alloc] init];
    locationManager.delegate = self;
    [locationManager.locationManager startUpdatingLocation];
    

    

}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    self.navigationItem.title = @"Banjogram";
}

-(void)viewWillDisappear:(BOOL)animated{
    self.navigationItem.title = @"Locations";
}

-(void)applyData:(NSNotification *) notification{
    
    if ([[notification name] isEqualToString:@"ApplyLocationSearchData"]){
        [self.tableView reloadData];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [[BSInstagramKit sharedInstance].instagramLocationSearchArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"LocationCellIdentifier";
    BSLocationCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    NSString *city = [[[BSInstagramKit sharedInstance].instagramLocationSearchArray objectAtIndex:indexPath.row] objectForKey:@"name"];
    cell.locationLabel.text = city;
    
    return cell;
}

- (void)locationUpdate:(CLLocation *)location {

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [BSInstagramKit getInstagramLocations:location];
    });

}

- (void)locationError:(NSError *)error {
   NSLog(@"location error:%@", [error description]);
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *location = [[BSInstagramKit sharedInstance].instagramLocationSearchArray objectAtIndex:indexPath.row];
    [BSInstagramKit sharedInstance].chosenLocationDict = location;
    // Navigation logic may go here. Create and push another view controller.
    

    
    BSInstagramMediaViewController *instagramViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"InstagramMediaViewIdentifier"];
    
    [[self navigationController] pushViewController:instagramViewController animated:YES];
    
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
