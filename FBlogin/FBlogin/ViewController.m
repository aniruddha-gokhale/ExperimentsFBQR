//
//  ViewController.m
//  FBlogin
//
//  Created by GDB Consultants on 26/03/16.
//  Copyright © 2016 GDB Technologies. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<FBLoginViewDelegate>

-(void)toggleHiddenState:(BOOL)shouldHide;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self toggleHiddenState:YES];
    self.lblLoginStatus.text = @"";
    self.loginButton.readPermissions = @[@"public_profile", @"email"];
    self.loginButton.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)toggleHiddenState:(BOOL)shouldHide{
    self.lblUsername.hidden = shouldHide;
    self.lblEmail.hidden = shouldHide;
    self.profilePicture.hidden = shouldHide;
}

-(void)loginViewShowingLoggedInUser:(FBLoginView *)loginView{
    self.lblLoginStatus.text = @"You are logged in.";
    
    [self toggleHiddenState:NO];
}

-(void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user{
    
    NSLog(@"%@", user);
    self.profilePicture.profileID = user.id;
    self.lblUsername.text = user.name;
    self.lblEmail.text = [user objectForKey:@"email"];
}

-(void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView{
    self.lblLoginStatus.text = @"You are logged out";
    
    [self toggleHiddenState:YES];
}

-(void)loginView:(FBLoginView *)loginView handleError:(NSError *)error{
    NSLog(@"%@", [error localizedDescription]);
}

@end
