//
//  SortMachine.m
//  FISInsta
//
//  Created by Cong Sun on 6/19/15.
//  Copyright (c) 2015 Cong Sun. All rights reserved.
//

#import "SortMachine.h"
#import "InstaObjectsDataStore.h"

@interface SortMachine()
@property InstaObjectsDataStore *dataStore;

@end



@implementation SortMachine


-(instancetype)init{
    self = [super init];
    if(self){
        _dataStore = [InstaObjectsDataStore sharedInstaObjectDataStore];
    }
    return self;
}

-(NSArray *)sortByLikesAcending:(BOOL)acending{
    NSArray *arrayToSort = self.dataStore.instaObjects;
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc]initWithKey:@"likes" ascending:acending];
    return [arrayToSort sortedArrayUsingDescriptors:@[descriptor]];
}


-(NSArray *)sortByLikesHighToLow{
    return [self sortByLikesAcending:NO];
}

-(NSArray *)sortByLikesLowToHigh{
    return [self sortByLikesAcending:YES];
}

-(NSArray *)sortByHashTag{
    
    
}
@end
