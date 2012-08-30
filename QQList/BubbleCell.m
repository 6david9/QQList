//
//  BubbleCell.m
//  QQList
//
//  Created by ly on 8/28/12.
//  Copyright (c) 2012 ly. All rights reserved.
//

#import "BubbleCell.h"

@interface BubbleCell()

@property (nonatomic, retain) UIImage *bubbleImage;
@end

@implementation BubbleCell
@synthesize bubbleImage;
@synthesize bubbleView;
@synthesize wordsLabel;

- (void)dealloc {
    [bubbleView release];
    [wordsLabel release];
    [super dealloc];
}


#pragma mark - Customed methods

- (void)setWords:(NSString *) words fromSelf:(BOOL)flag
{
    
    CGSize wordsSize = [words sizeWithFont:[UIFont systemFontOfSize:16.0f]
                         constrainedToSize:CGSizeMake(200.0f, 2000.0f)
                             lineBreakMode:UILineBreakModeWordWrap];
    
//    if (flag) {
//        self.bubbleImage = [[UIImage imageNamed:@"bubbleSelf.png"] stretchableImageWithLeftCapWidth:21 topCapHeight:14];
//    } else {
//        self.bubbleImage = [[UIImage imageNamed:@"bubble.png"] stretchableImageWithLeftCapWidth:21 topCapHeight:14];
//    }

    self.bubbleView.image = [[UIImage imageNamed:@"bubble.png"] stretchableImageWithLeftCapWidth:21 topCapHeight:14];
    [self.bubbleView setOpaque:NO];
    [self.bubbleView setClipsToBounds:YES];
    [self.bubbleView setClearsContextBeforeDrawing:YES];
    [self.bubbleView setBackgroundColor:[UIColor clearColor]];
    [self.bubbleView setContentMode:UIViewContentModeScaleToFill];
    self.bubbleView.frame = CGRectMake(30, 4, self.bubbleView.image.size.width + wordsSize.width, self.bubbleView.image.size.height + wordsSize.height);
    
    // 通过计算坐标重叠
    wordsLabel.frame = CGRectMake(30 + 21, 4 + 14, wordsSize.width, wordsSize.height);
    [wordsLabel setFont:[UIFont systemFontOfSize:16.0f]];
    [wordsLabel setAdjustsFontSizeToFitWidth:NO];
    [wordsLabel setNumberOfLines:0];
    [wordsLabel setBackgroundColor:[UIColor clearColor]];
    [wordsLabel setText:words];
    
    
}


@end
