//
//  MGGithub.h
//  MeditatorsGit
//
//  Created by Wonder on 14-7-31.
//  Copyright (c) 2014年 Yin Xiaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>

// OAuth Stuff
extern NSString * const accessToken;

typedef void (^GithubRequestTokenCompletionHandler)(NSData *data, NSURLResponse *response, NSError *error);

@interface MGGithubOauth : NSObject

@property (strong, nonatomic, readonly) NSString *accessToken;

// oauth 流程
+ (void)startOauthRequest;
+ (void)requestAccessTokenWithCallbackURL:(NSURL *)url andCompletionHandler:(GithubRequestTokenCompletionHandler)completionHandler;

// 辅助方法
+ (NSDictionary*)dictionaryFromOAuthResponseString:(NSString*)responseString;


@end
