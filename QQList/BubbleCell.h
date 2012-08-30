//
//  BubbleCell.h
//  QQList
//
//  Created by ly on 8/28/12.
//  Copyright (c) 2012 ly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BubbleCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UIImageView *bubbleView;
@property (retain, nonatomic) IBOutlet UILabel *wordsLabel;

- (void)setWords:(NSString *) words fromSelf:(BOOL) fromSelf;

@end
