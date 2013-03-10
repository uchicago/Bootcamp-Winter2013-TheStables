//
//  StableTableViewController.m
//  TheStables
//
//  Created by T. Andrew Binkowski on 3/6/13.
//  Copyright (c) 2013 T. Andrew Binkowski. All rights reserved.
//

#import "StableTableViewController.h"
#import "DetailViewController.h"
#import "Animal.h"

@interface StableTableViewController ()

@end

@implementation StableTableViewController

/*******************************************************************************
 * @method          viewDidLoad
 * @abstract        Called when a view loads
 * @description      
 ******************************************************************************/
- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    // Array of Kentucky Derby Winners
    NSArray *data = @[@"I'll Have Another", @"Animal Kingdom", @"Super Saver", @"Mine That Bird",@"Big Brown"];

    // Array of horse images
    NSArray *imageURLS = @[
                           @"http://farm3.staticflickr.com/2790/4209348482_407aaaf166_s.jpg",
                           @"http://farm3.staticflickr.com/2799/4170439825_fe9f9490e8_q.jpg",
                           @"http://farm1.staticflickr.com/188/399161674_ad879e3320_q.jpg",
                           @"http://farm2.staticflickr.com/1219/1106933147_cd20180b4e_q.jpg",
                           @"http://farm1.staticflickr.com/68/211240707_3a246dbd9f_q.jpg"
                           ];
    
    // Initialize array that will hold animal objects
    _horses = [NSMutableArray arrayWithCapacity:[data count]];
    
    // Create an Animal object for each horse and add the year
    int year = 2012;
    for (int i=0; i < [data count]; i++) {
        Animal *currentAnimal = [[Animal alloc] init];
        currentAnimal.name = [data objectAtIndex:i];
        currentAnimal.age = [NSNumber numberWithInt:year - i];
        currentAnimal.imageURL = [NSURL URLWithString:[imageURLS objectAtIndex:i]];
        [self.horses addObject:currentAnimal];
    }
}

/*******************************************************************************
 * @method          didReceiveMemoryWarning
 * @abstract        
 * @description
 ******************************************************************************/
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

/*******************************************************************************
 * @method          numberOfSectionsInTableView
 * @abstract        Return the number of sections.
 * @description
 ******************************************************************************/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

/*******************************************************************************
 * @method          tableView:numberOfRowsInSection:
 * @abstract        Return the number of rows in the section.
 * @description     
 ******************************************************************************/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.horses count];
}

/*******************************************************************************
 * @method          tableView:cellForRowAtIndexPath:
 * @abstract        Return a tableview cell
 * @description     
 ******************************************************************************/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"AnimalCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    Animal *currentAnimal = [self.horses objectAtIndex:indexPath.row];
    cell.textLabel.text = currentAnimal.name;
    cell.detailTextLabel.text = [currentAnimal.age description];
    [self setImageForCell:cell fromUrl:currentAnimal.imageURL];
    
    return cell;
}

#pragma mark - Table view delegate

/*******************************************************************************
 * @method          tableView:didSelectRowAtIndexPath:
 * @abstract        Called when a cell is tapped
 * @description     
 ******************************************************************************/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    NSLog(@"Clicked on cell %d", indexPath.row);
}

#pragma mark - Segue
/*******************************************************************************
 * @method          prepareForSegue:sender
 * @abstract        Called before a segue transition
 * @description
 ******************************************************************************/
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *path = [self.tableView indexPathForSelectedRow];
    Animal *selectedAnimal = [self.horses objectAtIndex:path.row];
    DetailViewController *dvc = segue.destinationViewController;
    dvc.currentAnimal = selectedAnimal;
}

#pragma mark - Image Downloading
/*******************************************************************************
 * @method          setImageForCell:fromUrl
 * @abstract        Async donwload of image data from a passed URL; the image is assigned to the cell that is passed
 * @description     WARNING: This is not a safe implementation of async downloading, check out AFNetworking on github for good example
 ******************************************************************************/
- (void) setImageForCell:(UITableViewCell*)theCell fromUrl:(NSURL*)theUrl
{
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // Define an image
        UIImage *downloadImage = nil;
        
        // Download data from the URL address
        NSData *responseData = [NSData dataWithContentsOfURL:theUrl];
        
        // Convert data to UIImage
        downloadImage = [UIImage imageWithData:responseData];
        
        // Check if image exists (download was ok)
        if (downloadImage) {
            
            // UI can't be updated from background thread, get back on main thread
            dispatch_async(dispatch_get_main_queue(), ^{
                
                // Assign the image to the cell properties
                theCell.imageView.image = downloadImage;
                    
                // Redraw the cell
                [theCell setNeedsLayout];
            });
        } else {
            NSLog(@"-- impossible download: %@", theUrl);
        }
	});
}

@end
