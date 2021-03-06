//
//  MGGithubNews.m
//  MeditatorsGit
//
//  Created by Wonder on 14-8-15.
//  Copyright (c) 2014年 Yin Xiaoyu. All rights reserved.
//

#import "MGGithubNewsStore.h"
#import "MGGithubRequest.h"

@interface MGGithubNewsStore ()

@property (nonatomic, strong, readwrite) NSDictionary *eventsDic;
@end

@implementation MGGithubNewsStore

// 延迟初始化，始终在需要使用变量的时候才进行变量的初始化
- (NSDictionary *)eventsDic
{
    if (!_eventsDic) {
        _eventsDic = [[NSDictionary alloc] init];
    }
    
    return _eventsDic;
}

- (NSArray *)createdAtArray
{
    if (!_createdAtArray) {
        _createdAtArray = [[NSArray alloc] init];
    }
    
    return _createdAtArray;
}

- (NSMutableArray *)loginArray
{
    if (!_loginArray) {
        _loginArray = [[NSMutableArray alloc] init];
    }
    
    return _loginArray;
}

- (NSMutableArray *)avatarArray
{
    if (!_avatarArray) {
        _avatarArray = [[NSMutableArray alloc] init];
    }
    
    return _avatarArray;
}

+ (instancetype)sharedStore {
    static id sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

//  刷新 JSON 数据
- (void)fetchNews
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    [MGGithubRequest requestNewsEventsWithCompletionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error) {
            NSHTTPURLResponse *httpResp = (NSHTTPURLResponse*)response;
            
            if (httpResp.statusCode == 200) {
                NSError *jsonError = nil;
                // 解析 JSON 数据
                self.eventsDic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
                if (!jsonError) {
                    self.createdAtArray = [self.eventsDic valueForKey:@"created_at"];
                    
                    NSArray *arr = [self.eventsDic valueForKey:@"actor"];
                    for (NSDictionary *obj in arr) {
                        NSString *loginString = [obj valueForKey:@"login"];
                        
                        // 从网址生成二进制数据，
                        // 再把 data 转换成 Image
                        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[obj valueForKey:@"avatar_url"]]];
                        UIImage *avatarImage = [UIImage imageWithData:imageData];
                        [self.loginArray addObject:loginString];
                        [self.avatarArray addObject:avatarImage];
                    }
                    //                NSLog(@"%@", self.avatarArray);
                    
                    // 主线程操作
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                        
                        // 发布通知：数据源已经更新
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"updatedData" object:nil];
                    });
                } else {
                    LogYellow(@"error:%@", jsonError);
                }
                
            }
        } else {
            LogYellow(@"\n json fetch error:%@", error);
        }
    }];
}



@end
