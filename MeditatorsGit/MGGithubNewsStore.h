//
//  MGGithubNews.h
//  MeditatorsGit
//
//  Created by Wonder on 14-8-15.
//  Copyright (c) 2014年 Yin Xiaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MGGithubNewsStore : NSObject

@property (nonatomic, strong, readonly) NSDictionary *eventsDic;
@property (nonatomic, strong) NSArray *createdAtArray;

+ (instancetype)sharedStore;
- (void)fetchNews;

@end
