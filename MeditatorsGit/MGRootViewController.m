//
//  MGViewController.m
//  MeditatorsGit
//
//  Created by Wonder on 14-7-31.
//  Copyright (c) 2014年 Yin Xiaoyu. All rights reserved.
//

#import "MGRootViewController.h"
#import "MGGithub.h"

@interface MGRootViewController ()

@end

@implementation MGRootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // 圆角 Button
    [self.logInButton.layer setMasksToBounds:YES];
    [self.logInButton.layer setCornerRadius:3];
    
    [self.logOutButton.layer setMasksToBounds:YES];
    [self.logOutButton.layer setCornerRadius:3];
}

- (IBAction)logInButton:(UIButton *)sender
{
    // 如果不存在 AccessToken
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"accessToken"]) {
        [MGGithub startOauthRequestWithCompletionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (error) {
                LogRed(@"Request error");
            }
        }];
    } else {
        // 如果存在 AccessToken 
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Token" message:@"你已经有了一个 AccessToken，请不要重复登录。" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }

    
    
}

- (IBAction)logOutButton:(UIButton *)sender
{
    //TODO: 登出功能
}
@end
