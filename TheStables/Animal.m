//
//  Animal.m
//  ItsAZooInThere
//
//  Created by T. Andrew Binkowski on 3/5/13.
//  Copyright (c) 2013 T. Andrew Binkowski. All rights reserved.
//

#import "Animal.h"

@implementation Animal

// The compiler generates getters and setters for declared @properties
// e.g. setName, setAge, setImage, setImageURL

/*******************************************************************************
 * @method          summary
 * @abstract        Print a descriptive string to the console
 * @description
 ******************************************************************************/
- (void)summary {
    
    NSLog(@">>>> Animal Object:\nName: %@\nAge: %@\nImageURL: %@\n",
          self.name,self.age,[self.imageURL absoluteString]);
    
}

@end
