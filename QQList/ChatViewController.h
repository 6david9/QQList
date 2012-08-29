//
//  ChatViewController.h
//  QQList
//
//  Created by ly on 8/27/12.
//  Copyright (c) 2012 ly. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ME (@"me")
#define OTHER (@"other")

@class BubbleCell;
@interface ChatViewController : UIViewController <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UIView *myInputView;
    IBOutlet UITableView *myTableView;
    NSMutableArray *chattHistory;
}
@property (retain, nonatomic) IBOutlet BubbleCell *bubbleCell;

@end
