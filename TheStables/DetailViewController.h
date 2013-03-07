//
//  DetailViewController.h
//  TheStables
//
//  Created by T. Andrew Binkowski on 3/6/13.
//  Copyright (c) 2013 T. Andrew Binkowski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Animal.h"

@interface DetailViewController : UIViewController

@property (strong, nonatomic) Animal *currentAnimal;
@property (weak, nonatomic) IBOutlet UIImageView *animalImage;
@property (weak, nonatomic) IBOutlet UILabel *animalName;

@end
