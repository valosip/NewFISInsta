//
//  ViewController.m
//  FISInsta
//
//  Created by Cong Sun on 6/18/15.
//  Copyright (c) 2015 Cong Sun. All rights reserved.
//

#import "ViewController.h"
#import "GetInstaData.h"
#import "InstaObjectsDataStore.h"
#import <InstagramSimpleOAuth.h>

@interface ViewController ()
@property (strong,nonatomic) InstaObjectsDataStore *dataStore;
@property (strong,nonatomic) NSString *userToken;
@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    GetInstaData *data = [[GetInstaData alloc]initWithUserToken:@"2028182358.3be1650.57335e2df16b4597b51d7f5e6ff3e2f2"];
    
    [data getDataStoreReadyWithCompletion:^{
        [self updateUI];
    }];


    // Do any additional setup after loading the view, typically from a nib.
}

-(void)updateUI
{
    
}


-(void)login{
    InstagramSimpleOAuthViewController*viewController = [[InstagramSimpleOAuthViewController alloc] initWithClientID:@"3be1650732ff4b45b1887c3b333994ed"
            clientSecret:@"68cf1c07835d49908ddffbd94580dde9"
             callbackURL:[NSURL URLWithString:@"http://fis.valosip.com"]
              completion:^(InstagramLoginResponse *response, NSError *error) {
                            NSLog(@"My Access Token is: %@", response.accessToken);
                            self.userToken = response.accessToken;
              }];
    [self presentViewController:viewController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
