//
//  BSInstagramMediaViewController.m
//  Banjogram
//
//  Created by Brian Soule on 12/10/12.
//  Copyright (c) 2012 Soule. All rights reserved.
//

#import "BSInstagramMediaViewController.h"
#import "BSInstagramKit.h"
#import "BSInstagramPreviewCell.h"
#import "BSImageViewController.h"
#import "AFHTTPClient.h"
#import "UIImageView+AFNetworking.h"



@interface BSInstagramMediaViewController ()

@end

NSString *kDetailedViewControllerID = @"InstagramMediaViewIdentifier";    // view controller storyboard id
NSString *kCellID = @"InstagramPreviewCellIdentifier";

@implementation BSInstagramMediaViewController

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applyData:)
                                                 name:@"ApplyMediaSearchData"
                                               object:nil];
    
    BSInstagramKit *iKit = [[BSInstagramKit alloc] init];
    [iKit getInstagramLocationMedia:[BSInstagramKit sharedInstance].chosenLocationDict];
	// Do any additional setup after loading the view.
 
}

-(void)viewWillAppear:(BOOL)animated{
       self.navigationController.navigationBar.tintColor = [UIColor grayColor];
}

-(void)applyData:(NSNotification *) notification{
    
    if ([[notification name] isEqualToString:@"ApplyMediaSearchData"]){
        [self.collectionView reloadData];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section;
{
    NSArray *pics = [BSInstagramKit sharedInstance].instagramLocationMediaArray;
    //NSString *imgUrl = [[[[pics objectAtIndex:indexPath.row] objectForKey:@"images"]
        return [pics count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    NSArray *pics = [BSInstagramKit sharedInstance].instagramLocationMediaArray;
    NSString *imgUrl = [[[[pics objectAtIndex:indexPath.row] objectForKey:@"images"] objectForKey:@"thumbnail"] objectForKey:@"url"];

    BSInstagramPreviewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:kCellID forIndexPath:indexPath];
    
    cell.label.text = [NSString stringWithFormat:@"{%ld,%ld}", (long)indexPath.row, (long)indexPath.section];
    
    // load the image for this cell
    NSString *imageToLoad = [NSString stringWithFormat:PLACEHOLDER_IMAGE, indexPath.row]; //temporary static image

    [cell.image setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:imageToLoad]];
    
    return cell;
}

// the user tapped a collection item, load and set the image on the detail view controller
//
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"])
    {
        NSIndexPath *selectedIndexPath = [[self.collectionView indexPathsForSelectedItems] objectAtIndex:0];
        
        NSLog(@"chosen image %d", [selectedIndexPath row]);

        NSString *imageNameToLoad = [NSString stringWithFormat:@"wat", selectedIndexPath.row];        
        NSString *pathToImage = [[NSBundle mainBundle] pathForResource:imageNameToLoad ofType:@"jpeg"];
        UIImage *image = [[UIImage alloc] initWithContentsOfFile:pathToImage];
        
        BSImageViewController *imageViewController = [segue destinationViewController];
        imageViewController.chosenImage = [selectedIndexPath row];
        imageViewController.image = image;
        //[imageViewController.image setImageWithURL:[NSURL URLWithString:@"http://i.imgur.com/r4uwx.jpg"] ];

    }
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
