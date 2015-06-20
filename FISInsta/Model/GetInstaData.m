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

@property (strong,nonatomic)InstaObjectsDataStore *dataStore;
@property (nonatomic) NSUInteger runThrough;
@property (strong,nonatomic)NSString *userToken;
@property (strong,nonatomic)NSMutableArray *jsonDictionariesArray;
//@property (strong,nonatomic)NSString *jsonPagination;

@property (strong,nonatomic)NSDictionary *dic;

@property (nonatomic, strong) void (^completionBlock)(void);

@end

@implementation GetInstaData

-(instancetype)initWithUserToken:(NSString *)userToken{
    self = [super init];
    if(self){
        _userToken = userToken;
//        _jsonPagination = @"";
        _jsonDictionariesArray = [[NSMutableArray alloc]init];
        _dataStore = [InstaObjectsDataStore sharedInstaObjectDataStore];
    }
    return self;
}

-(void)getInstaObjs{
    
    //[self getJsonDictionary];
    [self loadUserInfo];
    for(NSDictionary *jsonDic in self.jsonDictionariesArray){
        NSArray *dataArray = jsonDic[@"data"];
        for(NSDictionary *dataDic in dataArray){
            NSURL *url = [[NSURL alloc]initWithString: dataDic[@"images"][@"thumbnail"][@"url"]];
            NSURL *largeImageUrl = [[NSURL alloc]initWithString: dataDic[@"images"][@"low_resolution"][@"url"]];
            NSString *likes = dataDic[@"likes"][@"count"];
            NSArray *HashTages = dataDic[@"tags"];
            //NSLog(@"images%@/n/n",url);
            InstaObject *dataObject = [[InstaObject alloc]initWithImageUrl:url
                                                                     Likes:likes.integerValue HashTages:HashTages LargeImageUrl:largeImageUrl];
            [self.dataStore.instaObjects addObject:dataObject];
        }
    }
    
    //NSLog(@"getInstaObjs: %ld", self.runThrough);
    ++self.runThrough;
    NSLog(@"Finish getInstaObjs");
    NSLog(@"%@",self.dataStore.instaObjects);
    
    
    
}

-(void)getDataStoreReadyWithCompletion:(void (^)(void))completionBlock {
    //make initial url
    
    self.completionBlock = completionBlock;
    
    NSString *url = [NSString stringWithFormat:@"https://api.instagram.com/v1/users/self/media/recent/?access_token=%@",self.userToken];
    
    //get json until there is no more images and put the dictionaries into the array
    [self httpRequestWithURL:url];
//    [self loadUserInfo];
    
    NSLog(@"Finish the getDataStoreReady");
    
}

-(void) loadUserInfo{
    NSDictionary *temp = self.jsonDictionariesArray[0];
    NSDictionary *userInfoDic = temp[@"data"][0][@"user"];
    self.dataStore.userInfo.userName = userInfoDic[@"username"];
    self.dataStore.userInfo.profilePic = [NSURL URLWithString:userInfoDic[@"profile_picture"]];
    self.dataStore.userInfo.fullName = userInfoDic[@"full_name"];
    
}

-(void)httpRequestWithURL:(NSString *)url{
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.dic = responseObject;
        [self.jsonDictionariesArray addObject:self.dic];
        //NSLog(@"here!!!!");
        
        if(self.dic[@"pagination"][@"next_url"]){
            
            [self httpRequestWithURL:self.dic[@"pagination"][@"next_url"]];
        }else{
            
            NSLog(@"Finish the httpRequestWithURL");
            
            [self getInstaObjs];
            
            // .. done fetching everything now
            self.completionBlock();
            self.completionBlock = nil;
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    
    NSLog(@"httpRequestWithUrl: %ld", self.runThrough);
    self.runThrough++;

    
}

@end
