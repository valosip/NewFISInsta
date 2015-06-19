//
//  HashTagObject.h
//  FISInsta
//
//  Created by Cong Sun on 6/19/15.
//  Copyright (c) 2015 Cong Sun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HashTagObject : NSObject
@property (strong,nonatomic) NSString *hashTagName;
@property (strong,nonatomic) NSArray *instaObjectArrayWithSameHashTag;
@property (nonatomic) NSUInteger count;

-(instancetype)initWithName:(NSString *)name InstaObjectsWithSameHashTag:(NSMutableArray *)instaObjectArrayWithSameHashTag;
@end
