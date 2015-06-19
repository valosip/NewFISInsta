//
//  InstaObjectsDataStore.h
//  FISInsta
//
//  Created by Cong Sun on 6/18/15.
//  Copyright (c) 2015 Cong Sun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InstaObject.h"

@interface InstaObjectsDataStore : NSObject
@property (strong,nonatomic)NSMutableArray *instaObjects;
+(instancetype)sharedInstaObjectDataStore;
@end
