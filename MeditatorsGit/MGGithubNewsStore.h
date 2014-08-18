//
//  MGGithubNews.h
//  MeditatorsGit
//
//  Created by Wonder on 14-8-15.
//  Copyright (c) 2014年 Yin Xiaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MGGithubNewsStore : NSObject

@property (strong, readonly, nonatomic) NSDictionary *eventsDic;

@property (strong, nonatomic) NSMutableDictionary *actorDictionary;
@property (strong, nonatomic) NSArray *createdAtArray;
@property (strong, nonatomic) NSMutableArray *loginArray;


+ (instancetype)sharedStore;
- (void)fetchNews;

@end
