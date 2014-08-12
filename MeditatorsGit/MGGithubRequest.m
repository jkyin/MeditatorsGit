//
//  MGGithubReceivedEvents.m
//  MeditatorsGit
//
//  Created by Wonder on 14-8-8.
//  Copyright (c) 2014年 Yin Xiaoyu. All rights reserved.
//

#import "MGGithubRequest.h"

@implementation MGGithubRequest

+ (void)requestNewsEventsWithCompletionHandler:(GithubReceivedEventsCompletionHandler)completionHandler
{
    NSString *urlString = [NSString stringWithFormat:@"https://api.github.com/users/jkyin/received_events"];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    [[session dataTaskWithURL:url completionHandler:completionHandler] resume];
}

@end
