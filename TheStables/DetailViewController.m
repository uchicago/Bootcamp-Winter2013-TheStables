//
//  DetailViewController.m
//  TheStables
//
//  Created by T. Andrew Binkowski on 3/6/13.
//  Copyright (c) 2013 T. Andrew Binkowski. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

/*******************************************************************************
 * @method          viewDidLoad
 * @abstract        Called when view is loaded
 * @description      
 ******************************************************************************/
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

/*******************************************************************************
 * @method          viewWillAppear
 * @abstract        Called before view appears
 * @description
 ******************************************************************************/
- (void)viewWillAppear:(BOOL)animated {
    self.animalName.text = self.currentAnimal.name;
    [self setImage:self.animalImage fromUrl:self.currentAnimal.imageURL];
}

/*******************************************************************************
 * @method          didReceiveMemoryWarning
 * @abstract        Called when memory warning
 * @description      
 ******************************************************************************/
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Image Downloading
/*******************************************************************************
 * @method          setImage:fromUrl:
 * @abstract        Async donwload of image data from a passed URL; the image is assigned to the cell that is passed
 * @description     WARNING: This is not a safe implementation of async downloading, check out AFNetworking on github for good example
 ******************************************************************************/
- (void) setImage:(UIImageView *)theImageView fromUrl:(NSURL*)theUrl
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
                theImageView.image = downloadImage;
            });
        } else {
            NSLog(@"-- impossible download: %@", theUrl);
        }
	});
}
@end
