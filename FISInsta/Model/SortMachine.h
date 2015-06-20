//
//  SortMachine.h
//  FISInsta
//
//  Created by Cong Sun on 6/19/15.
//  Copyright (c) 2015 Cong Sun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SortMachine : NSObject
-(NSArray *)sortByLikesHighToLow;
-(NSArray *)sortByLikesLowToHigh;
-(NSArray *)sortByHashTagCount;

@end
