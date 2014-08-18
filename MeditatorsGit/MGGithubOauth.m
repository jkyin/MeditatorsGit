//
//  MGGithub.m
//  MeditatorsGit
//
//  Created by Wonder on 14-7-31.
//  Copyright (c) 2014年 Yin Xiaoyu. All rights reserved.
//

#import "MGGithubOauth.h"

// Github stuff
static NSString *client_id = @"e97b03211595b394c4c4";
static NSString *client_secret = @"beaa22be2462eeefc15680f0db446dbf0600eb3c";

// saved in NSUserDefaults
NSString * const accessToken = @"access_token";



@implementation MGGithubOauth

#pragma mark - Oauth 2 flow

// Github Oauth 验证第一步：打开授权页面。
+ (void)startOauthRequest
{
    NSString *urlString = [NSString stringWithFormat:@"https://github.com/login/oauth/authorize?client_id=%@", client_id];
    NSURL *url = [NSURL URLWithString:urlString];
    LogCoco(@"%@", urlString);
    
    [[UIApplication sharedApplication] openURL:url];
}

// Github Oauth 验证第二步：使用随机 Code 来获取 AccessToken。
+ (void)requestAccessTokenWithCallbackURL:(NSURL *)url andCompletionHandler:(GithubRequestTokenCompletionHandler)completionHandler
{
    NSString *code = [self temporaryCodeFromCallbackURL:url];
    NSString *urlString = [NSString stringWithFormat:@"https://github.com/login/oauth/access_token?client_id=%@&client_secret=%@&code=%@", client_id, client_secret, code];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithRequest:request completionHandler:completionHandler] resume];
    LogCoco(@"%@", urlString);
}

#pragma mark - 辅助方法

// 获取随机 Code
+ (NSString *)temporaryCodeFromCallbackURL:(NSURL *)callbackURL
{
    return [[[callbackURL absoluteString] componentsSeparatedByString:@"="] lastObject];
}

+ (NSDictionary *)dictionaryFromOAuthResponseString:(NSString *)responseString
{
    // 分离回调参数
    NSArray *parameters = [responseString componentsSeparatedByString:@"&"];
    NSMutableDictionary *oauthDic = [[NSMutableDictionary alloc] init];
    
    // 分离参数中的值，并储存到字典中。
    for (NSString *t in parameters) {
        NSArray *entry = [t componentsSeparatedByString:@"="];
        NSString *key = entry[0];
        NSString *value = entry[1];
        [oauthDic setObject:value forKey:key];
    }
    return [NSDictionary dictionaryWithDictionary:oauthDic];
}

@end
