//
//  MGNewsViewController.m
//  MeditatorsGit
//
//  Created by Wonder on 14-8-8.
//  Copyright (c) 2014年 Yin Xiaoyu. All rights reserved.
//

#import "MGNewsTableViewController.h"
#import "MGTableViewCell.h"
#import "MGGithubNewsStore.h"


@interface MGNewsTableViewController ()

@end

@implementation MGNewsTableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 订阅通知：当数据源更新的时候刷新视图
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:@"updatedData" object:nil];
    [[MGGithubNewsStore sharedStore] fetchNews];
}

- (void)refresh
{
    [self.tableView reloadData];
}

#pragma mark - UITableVIew Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[MGGithubNewsStore sharedStore].eventsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MGTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MGCell"];
    
    return cell;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
