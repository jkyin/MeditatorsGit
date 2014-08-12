//
//  MGGithubReceivedEvents.h
//  MeditatorsGit
//
//  Created by Wonder on 14-8-8.
//  Copyright (c) 2014年 Yin Xiaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^GithubReceivedEventsCompletionHandler)(NSData *data, NSURLResponse *response, NSError *error);

@interface MGGithubRequest : NSObject

/**
 *  发送获取 NewsEvents 请求
 *
 *  @param ompletionHandler 完成处理程序
 */
+ (void)requestNewsEventsWithCompletionHandler:(GithubReceivedEventsCompletionHandler)ompletionHandler;

@end
