//
//  Animal.h
//  ItsAZooInThere
//
//  Created by T. Andrew Binkowski on 3/5/13.
//  Copyright (c) 2013 T. Andrew Binkowski. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Animal : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSNumber *age;
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) NSURL *imageURL;

- (void)summary;

@end
