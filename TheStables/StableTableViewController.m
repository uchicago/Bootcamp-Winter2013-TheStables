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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    NSArray *data = @[@"I'll Have Another", @"Animal Kingdom", @"Super Saver", @"Mine That Bird",
                      @"Big Brown", @"Street Sense", @"Barbaro", @"Giacomo", @"Smarty Jones", @"Funny Cide",
                      @"War Emblem", @"Monarchos", @"Fusaichi Pegasus"];
    NSArray *imageURLS = @[
                           @"http://kyderbyfan.freeservers.com/horses/barbaro.jpg",
                           @"http://kyderbyfan.freeservers.com/horses/giacomo.jpg",
                           @"http://kyderbyfan.freeservers.com/horses/smartyjones.jpg",
                           @"http://kyderbyfan.freeservers.com/horses/funnycide.jpg",
                           @"http://kyderbyfan.freeservers.com/horses/waremblem.jpg",
                           @"http://kyderbyfan.freeservers.com/horses/monarchos.jpg",
                           @"http://kyderbyfan.freeservers.com/horses/fupeg_coolmore.jpg",
                           @"http://kyderbyfan.freeservers.com/horses/barbaro.jpg",
                           @"http://kyderbyfan.freeservers.com/horses/giacomo.jpg",
                           @"http://kyderbyfan.freeservers.com/horses/smartyjones.jpg",
                           @"http://kyderbyfan.freeservers.com/horses/funnycide.jpg",
                           @"http://kyderbyfan.freeservers.com/horses/waremblem.jpg",
                           @"http://kyderbyfan.freeservers.com/horses/monarchos.jpg",
                           @"http://kyderbyfan.freeservers.com/horses/fupeg_coolmore.jpg"
                           ];
    
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.horses count];
}

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

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    NSLog(@"Clicked on cell %d", indexPath.row);
}

#pragma mark - Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *path = [self.tableView indexPathForSelectedRow];
    Animal *selectedAnimal = [self.horses objectAtIndex:path.row];
    DetailViewController *dvc = segue.destinationViewController;
    dvc.currentAnimal = selectedAnimal;
}


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
