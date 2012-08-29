//
//  SectionHeaderView.m
//  QQList
//
//  Created by ly on 8/27/12.
//  Copyright (c) 2012 ly. All rights reserved.
//

#import "SectionHeaderView.h"

@implementation SectionHeaderView

- (void)dealloc {
    [super dealloc];
}

#pragma mark - Customed methods
- (void)setGroupTitle:(NSString *) title
{
    [groupTitleLabel setText:title];
}

- (void)setGroupButtonImage:(UIImage *) aImage
{
    [expandOrShrinkButton setImage:aImage forState:UIControlStateNormal];
}

- (void)setTagForSectionHeaderViewButton:(NSUInteger) aTag
{
    [expandOrShrinkButton setTag:aTag];
}

@end
