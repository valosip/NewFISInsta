//
//  InstaObjectsDataStore.m
//  FISInsta
//
//  Created by Cong Sun on 6/18/15.
//  Copyright (c) 2015 Cong Sun. All rights reserved.
//

#import "InstaObjectsDataStore.h"

@implementation InstaObjectsDataStore

-(instancetype)init{
    self = [super init];
    if(self){
        _instaObjects = [[NSMutableArray alloc]init];
        _userInfo = [[UserInfo alloc]init];
    }
    return self;
}

+(instancetype)sharedInstaObjectDataStore{
    static InstaObjectsDataStore *_InstaObjectStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _InstaObjectStore = [[InstaObjectsDataStore alloc]init];
    });
    return _InstaObjectStore;
}

@end
