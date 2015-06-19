//
//  GetInstaData.h
//  FISInsta
//
//  Created by Cong Sun on 6/18/15.
//  Copyright (c) 2015 Cong Sun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetInstaData : NSObject
-(instancetype)initWithUserToken:(NSString *)userToken;
-(void)getInstaObjs;
@end
