//
//  InstaObject.h
//  FISInsta
//
//  Created by Cong Sun on 6/18/15.
//  Copyright (c) 2015 Cong Sun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InstaObject : NSObject
@property (strong,nonatomic)NSURL *imageUrl;
@property (strong, nonatomic)NSArray *hashTags;
@property (nonatomic) NSUInteger likes;

@end
