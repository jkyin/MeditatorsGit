//
//  MGTableViewCell.h
//  MeditatorsGit
//
//  Created by Wonder on 14-8-8.
//  Copyright (c) 2014年 Yin Xiaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MGTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *actorLoginLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;

@end
