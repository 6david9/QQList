//
//  GroupTableViewCell.h
//  QQList
//
//  Created by ly on 8/27/12.
//  Copyright (c) 2012 ly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupTableViewCell : UITableViewCell
{
    IBOutlet UIImageView *headPortrait;
    IBOutlet UILabel *nameLabel;
}

- (void)setCellImage:(UIImage *) image;
- (void)setCellName:(NSString *) name;

@end
