//
//  SortMachine.m
//  FISInsta
//
//  Created by Cong Sun on 6/19/15.
//  Copyright (c) 2015 Cong Sun. All rights reserved.
//

#import "SortMachine.h"
#import "InstaObjectsDataStore.h"
#import "InstaObject.h"
#import "HashTagObject.h"

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

-(NSArray *)sortByHashTagCount{
    NSArray *arrayToSort = self.dataStore.instaObjects;
    NSMutableDictionary *hashTagDictionary = [[NSMutableDictionary alloc]init];
    for(InstaObject *imageProfile in arrayToSort){
        NSArray *hashTagArr = imageProfile.hashTags;
        for(NSString *hashTag in hashTagArr){
            if (hashTagDictionary[hashTag]) {
                NSMutableArray *sameHashTagArray = hashTagDictionary[hashTag];
                [sameHashTagArray addObject:imageProfile];
            }else{
                NSMutableArray *sameHashTagArray = [[NSMutableArray alloc]init];
                [sameHashTagArray addObject: imageProfile];
                [hashTagDictionary setValue:sameHashTagArray forKey:hashTag];
            }
        }
    }
    NSMutableArray *hashTagObjectsArray = [[NSMutableArray alloc]init];
    for(NSString *key in hashTagDictionary){
        HashTagObject *object = [[HashTagObject alloc]initWithName:key InstaObjectsWithSameHashTag:hashTagDictionary[key]];
        [hashTagObjectsArray addObject:object];
    }
    
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc]initWithKey:@"count" ascending:NO];
    
    [hashTagObjectsArray sortUsingDescriptors:@[descriptor]];
    
    return hashTagObjectsArray;
    
}




@end
