//
//  InstaObject.m
//  FISInsta
//
//  Created by Cong Sun on 6/18/15.
//  Copyright (c) 2015 Cong Sun. All rights reserved.
//

#import "InstaObject.h"

@implementation InstaObject
-(instancetype)initWithImageUrl:(NSURL *)imageUrl Likes:(NSUInteger)likes HashTages:(NSArray *)hashTags LargeImageUrl:(NSURL *)largeImageUrl{
    
    self = [super init];
    if(self){
        _imageUrl = imageUrl;
        _hashTags = hashTags;
        _likes = likes;
        _largeImageUrl = largeImageUrl;
    }
    return self;
}
@end
