//
//  GroupTableViewCell.m
//  QQList
//
//  Created by ly on 8/27/12.
//  Copyright (c) 2012 ly. All rights reserved.
//

#import "GroupTableViewCell.h"

@implementation GroupTableViewCell

- (void)setCellImage:(UIImage *) image
{
    [headPortrait setImage:image];
}

- (void)setCellName:(NSString *) name
{
    [nameLabel setText:name];
}

@end
