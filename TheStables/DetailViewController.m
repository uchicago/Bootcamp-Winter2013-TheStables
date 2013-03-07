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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    self.animalName.text = self.currentAnimal.name;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
