//
//  SectionHeaderView.h
//  QQList
//
//  Created by ly on 8/27/12.
//  Copyright (c) 2012 ly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SectionHeaderView : UIImageView
{
    IBOutlet UIButton *expandOrShrinkButton;
    IBOutlet UILabel *groupTitleLabel;
}

- (void)setGroupTitle:(NSString *) title;
- (void)setGroupButtonImage:(UIImage *) aImage;
- (void)setTagForSectionHeaderViewButton:(NSUInteger) aTag;
@end
