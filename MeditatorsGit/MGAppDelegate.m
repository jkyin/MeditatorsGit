//
//  MGAppDelegate.m
//  MeditatorsGit
//
//  Created by Wonder on 14-7-31.
//  Copyright (c) 2014年 Yin Xiaoyu. All rights reserved.
//

#import "MGAppDelegate.h"
#import "MGGithubOauth.h"

@implementation MGAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self initAppearance];
    
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:accessToken];
    
    NSString *controllerID = token ? @"TabBar" : @"Login";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *initViewController = [storyboard instantiateViewControllerWithIdentifier:controllerID];
    
    if (token) {
        [self.window setRootViewController:initViewController];
    } else {
        [(UINavigationController *)self.window.rootViewController pushViewController:initViewController animated:NO];
    }
    
    return YES;
}

/**
 *  Oauth 验证回调方法
 */
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    [MGGithubOauth requestAccessTokenWithCallbackURL:url andCompletionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error) {
            NSString *accessTokenData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSDictionary *dic = [MGGithubOauth dictionaryFromOAuthResponseString:accessTokenData];
            LogCoco(@"%@", dic);
            NSString *token = [dic objectForKey:accessToken];
            LogCoco(@"%@", token);
            
            [[NSUserDefaults standardUserDefaults] setObject:token forKey:accessToken];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            LogYellow(@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:accessToken]);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSString *segueId = @"TabBar";
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                UITabBarController *initViewController = [storyboard instantiateViewControllerWithIdentifier:segueId];
                
                UINavigationController *nav = (UINavigationController *) self.window.rootViewController;
                nav.navigationBar.hidden = YES;
                [nav pushViewController:initViewController animated:NO];
            });
        }
    }];
    
    return YES;
}
- (void)initAppearance
{
    UIColor *byteClubGreen = [UIColor colorWithRed:0.376 green:0.690 blue:0.267 alpha:1.000];
    
    // Set appearance info
    [[UITabBar appearance] setBarTintColor:byteClubGreen];
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlackOpaque];
    [[UINavigationBar appearance] setBarTintColor:byteClubGreen];
    
    [[UIToolbar appearance] setBarStyle:UIBarStyleBlackOpaque];
    [[UIToolbar appearance] setBarTintColor:byteClubGreen];
    
}

@end
