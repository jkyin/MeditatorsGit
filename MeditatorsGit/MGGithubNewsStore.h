//
//  MGGithubNews.h
//  MeditatorsGit
//
//  Created by Wonder on 14-8-15.
//  Copyright (c) 2014年 Yin Xiaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MGGithubNewsStore : NSObject

@property (nonatomic, strong, readonly) NSArray *eventsArray;
@property (nonatomic, strong) NSDictionary *eventsDic;
+ (instancetype)sharedStore;
- (void)fetchNews;

@end
