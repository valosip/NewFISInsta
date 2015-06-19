//
//  HashTagObject.m
//  FISInsta
//
//  Created by Cong Sun on 6/19/15.
//  Copyright (c) 2015 Cong Sun. All rights reserved.
//

#import "HashTagObject.h"
@implementation HashTagObject
-(instancetype)initWithName:(NSString *)name InstaObjectsWithSameHashTag:(NSMutableArray *)instaObjectArrayWithSameHashTag{
    self = [super init];
    if(self){
        _hashTagName = name;
        _instaObjectArrayWithSameHashTag = instaObjectArrayWithSameHashTag;
        _count = instaObjectArrayWithSameHashTag.count;
    }
    return self;
}
-(instancetype)init{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    return [self initWithName:@"" InstaObjectsWithSameHashTag:array];
}


-(void)setInstaObjectArrayWithSameHashTag:(NSArray *)instaObjectArrayWithSameHashTag{
    _instaObjectArrayWithSameHashTag = instaObjectArrayWithSameHashTag;
    _count = instaObjectArrayWithSameHashTag.count;
}

//-(NSUInteger)count{
//    return self.instaObjectArrayWithSameHashTag.count;
//}
@end
