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
@interface ChatViewController : UIViewController < UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
{
    IBOutlet UIView *inputArea;
    IBOutlet UITableView *chattingTableView;
    IBOutlet UITextField *msgTextField;
    NSMutableArray *chattingHistory;
}
@property (retain, nonatomic) IBOutlet BubbleCell *bubbleCell;
- (IBAction)sendMessage:(id)sender;

@end