//
//  MGAppDelegate.m
//  MeditatorsGit
//
//  Created by Wonder on 14-7-31.
//  Copyright (c) 2014年 Yin Xiaoyu. All rights reserved.
//

#import "MGAppDelegate.h"
#import "MGGithub.h"

@implementation MGAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self initAppearance];
    
    return YES;
}
							
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    [MGGithub requestAccessTokenWithCallbackURL:url andCompletionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error) {
            NSString *accessTokenData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSDictionary *dic = [MGGithub dictionaryFromOAuthResponseString:accessTokenData];
            LogCoco(@"%@", dic);
            NSString *accessToken = [dic objectForKey:@"access_token"];
            LogCoco(@"%@", accessToken);
            
            [[NSUserDefaults standardUserDefaults] setObject:accessToken forKey:@"accessToken"];
            
            
            LogYellow(@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"accessToken"]);
        }
    }];
    
    return YES;
}
- (void)initAppearance
{
    UIColor *byteClubGreen = [UIColor colorWithRed:0.376 green:0.690 blue:0.267 alpha:1.000];
    
    // Set appearance info
//    [[UITabBar appearance] setBarTintColor:byteClubBlue];
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlackOpaque];
    [[UINavigationBar appearance] setBarTintColor:byteClubGreen];
    
//    [[UIToolbar appearance] setBarStyle:UIBarStyleBlackOpaque];
//    [[UIToolbar appearance] setBarTintColor:byteClubBlue];
    
}

@end
