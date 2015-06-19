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

@interface ViewController ()
@property (strong,nonatomic) InstaObjectsDataStore *dataStore;
@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    GetInstaData *data = [[GetInstaData alloc]initWithUserToken:@"2028182358.3be1650.57335e2df16b4597b51d7f5e6ff3e2f2"];
    [data getJsonDictionary];
    
    
    self.dataStore = [InstaObjectsDataStore sharedInstaObjectDataStore];
    NSLog(@"%@", self.dataStore);
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
