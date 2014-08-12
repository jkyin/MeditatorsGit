//
//  MGNewsViewController.m
//  MeditatorsGit
//
//  Created by Wonder on 14-8-8.
//  Copyright (c) 2014年 Yin Xiaoyu. All rights reserved.
//

#import "MGNewsTableViewController.h"
#import "MGTableViewCell.h"
#import "MGGithubRequest.h"


@interface MGNewsTableViewController ()

@end

@implementation MGNewsTableViewController

// 延迟初始化，始终在需要使用变量的时候才进行变量的初始化
- (NSMutableArray *)eventsArray
{
    if (!_eventsArray) {
        _eventsArray = [[NSMutableArray alloc] init];
    }
    
    return _eventsArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self refresh];
}

/**
 *  刷新 JSON 数据
 */
- (void)refresh
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    [MGGithubRequest requestNewsEventsWithCompletionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error) {
            NSHTTPURLResponse *httpResp = (NSHTTPURLResponse*)response;
            if (httpResp.statusCode == 200) {
                self.eventsArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                LogCoco(@"\n%@", _eventsArray[0]);
                
                // 在主线程更新 UI
                dispatch_async(dispatch_get_main_queue(), ^{
                    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                    [self.tableView reloadData];
                });
            }
        } else {
            LogYellow(@"json fetch error:%@", error);
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_eventsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MGTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MGCell"];
    
    return cell;
}

@end
