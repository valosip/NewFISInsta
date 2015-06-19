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
//@property (strong,nonatomic)NSMutableArray *jsonDictionariesArray;
//@property (strong,nonatomic)NSString *jsonPagination;
@property (strong,nonatomic)InstaObjectsDataStore *dataStore;

@property (strong,nonatomic)NSDictionary *dic;
@end

@implementation GetInstaData

-(instancetype)initWithUserToken:(NSString *)userToken{
    self = [super init];
    if(self){
        _userToken = userToken;
//        _jsonPagination = @"";
//        _jsonDictionariesArray = [[NSMutableArray alloc]init];
        _dataStore = [InstaObjectsDataStore sharedInstaObjectDataStore];
    }
    return self;
}

-(void)getInstaObjs{
    NSMutableArray *jsonDictionariesArray = [[NSMutableArray alloc]init];
    //initially the self.jsonPagination is @""
    NSString *url = [NSString stringWithFormat:@"https://api.instagram.com/v1/users/self/media/recent/?access_token=%@",self.userToken];
    [self httpRequestWithURL:url Array:jsonDictionariesArray];
    NSMutableArray *array = [self getJsonDictionary];
    NSLog(@"%@",array);
    for(NSDictionary *jsonDic in array){
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

-(NSMutableArray *)getJsonDictionary{
    NSMutableArray *jsonDictionariesArray = [[NSMutableArray alloc]init];
    //initially the self.jsonPagination is @""
    NSString *url = [NSString stringWithFormat:@"https://api.instagram.com/v1/users/self/media/recent/?access_token=%@",self.userToken];
    [self httpRequestWithURL:url Array:jsonDictionariesArray];
    
    //get json until there is no more images and put the dictionaries into the array
//    do {
//        [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//            self.dic = responseObject;
//            NSLog(@"%@",self.dic);
//            self.jsonPagination = self.dic[@"pagination"][@"next_max_id"];
//            [self.jsonDictionariesArray addObject:self.dic];
//            NSLog(@"here!!!!");
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            NSLog(@"Error: %@", error);
//        }];
//
//    } while ([self.dic[@"pagination"][@"next_max_id"] isEqualToString:@""]);
    
    
    return jsonDictionariesArray;
}

-(void)httpRequestWithURL:(NSString *)url Array:(NSMutableArray *)array{
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.dic = responseObject;
        [array addObject:self.dic];
        NSLog(@"here!!!!");
        if(self.dic[@"pagination"][@"next_url"]){
            [self httpRequestWithURL:self.dic[@"pagination"][@"next_url"] Array:array];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

}

@end
