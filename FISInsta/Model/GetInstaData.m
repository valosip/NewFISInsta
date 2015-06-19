//
//  GetInstaData.m
//  FISInsta
//
//  Created by Cong Sun on 6/18/15.
//  Copyright (c) 2015 Cong Sun. All rights reserved.
//

#import "GetInstaData.h"
#import <AFNetworking.h>
#import <InstagramSimpleOAuth.h>
#import "InstaObject.h"
#import "InstaObjectsDataStore.h"
@interface GetInstaData()
@property (strong,nonatomic)NSString *userToken;
@property (strong,nonatomic)NSMutableArray *jsonDictionariesArray;
@property (strong,nonatomic)NSString *jsonPagination;
@property (strong,nonatomic)InstaObjectsDataStore *dataStore;

@property (strong,nonatomic)NSDictionary *dic;
@end

@implementation GetInstaData

-(instancetype)initWithUserToken:(NSString *)userToken{
    self = [super init];
    if(self){
        _userToken = userToken;
        _jsonPagination = @"";
        _jsonDictionariesArray = [[NSMutableArray alloc]init];
        _dataStore = [InstaObjectsDataStore sharedInstaObjectDataStore];
    }
    return self;
}

-(void)getInstaData{
    [self getJsonDictionary];
    for(NSDictionary *jsonDic in self.jsonDictionariesArray){
        NSArray *dataArray = jsonDic[@"data"];
        for(NSDictionary *dataDic in dataArray){
            NSURL *url = [[NSURL alloc]initWithString: dataDic[@"images"][@"thumbnail"][@"url"]];
            NSString *likes = dataDic[@"likes"][@"count"];
            NSArray *HashTages = dataDic[@"tags"];
            NSLog(@"images%@/n/n",url);
            InstaObject *dataObject = [[InstaObject alloc]initWithImageUrl:url
                                                                     Likes:likes.integerValue HashTages:HashTages];
            [self.dataStore.instaObjects addObject:dataObject];
        }
    }
    
    
    
}

-(void)getJsonDictionary{
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    
    //initially the self.jsonPagination is @""
    NSString *url = [NSString stringWithFormat:@"https://api.instagram.com/v1/users/self/media/recent/?access_token=%@%@",self.userToken,self.jsonPagination];
    
    //get json until there is no more images and put the dictionaries into the array
    do {
        [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *jsonDictionary = responseObject;
            NSLog(@"%@",jsonDictionary);
            self.jsonPagination = jsonDictionary[@"pagination"][@"next_max_id"];
            [self.jsonDictionariesArray addObject:jsonDictionary];
            NSLog(@"here!!!!");
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];

    } while (self.jsonPagination);
    
    
    
}

@end
