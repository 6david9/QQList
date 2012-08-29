//
//  ChatViewController.m
//  QQList
//
//  Created by ly on 8/27/12.
//  Copyright (c) 2012 ly. All rights reserved.
//

#import "ChatViewController.h"
#import "BubbleCell.h"
#import "ChattingData.h"

#define needGenerateHistory 1           // 1 生成伪造聊天纪录
                                        // 0 不生成伪造聊天纪录

@interface ChatViewController (Private)

// 显示或隐藏inputView(默认系统键盘)时，改变布局
- (void)changeLayoutFrame;

- (void)scrollViewToEnd;

@end

@implementation ChatViewController
@synthesize bubbleCell;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 注册观察者，监视键盘状态通知
    // 键盘状态通知由 UIWindow 实例发送
    // 
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(changeLayoutFrame:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(changeLayoutFrame:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    // 为chattingHistory分配内存
    chattingHistory = [[NSMutableArray alloc] initWithCapacity:10];
    
#if needGenerateHistory
    @autoreleasepool {
        
        for (NSUInteger i = 0; i < 10; i++) {
            
            NSDictionary *dict = nil;
            
            if (i % 2 == 0) {   // 奇数行
                
                ChattingData *newData = [[ChattingData alloc] initWithWords:@"me:bla bla bla" Character:ChattingCharacterMe];
                dict = [[NSDictionary alloc] initWithObjectsAndKeys:newData, ME, nil];
                [newData release];
                
            } else {            // 偶数行
                
                ChattingData *newData = [[ChattingData alloc] initWithWords:@"other:bla bla bla" Character:ChattingCharacterOther];
                dict = [[NSDictionary alloc] initWithObjectsAndKeys:newData, OTHER, nil];
                [newData release];
            }
            
            [chattingHistory addObject:dict];
        }
        
    for (NSDictionary *data in chattingHistory) {
        NSString *key = [[data allKeys] lastObject];
        NSLog(@"%@", [[data valueForKey:key] words]);
    }
        
    }
#endif
    
}

- (void)viewDidUnload
{
    [chattingHistory release], chattingHistory = nil;
    [self setBubbleCell:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
    [bubbleCell release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Customed methods
- (void)changeLayoutFrame:(NSNotification *) notification
{
     /* 
        假定屏幕方向一直为 UIInterfaceOrientationPortrait
      
        ***所使用坐标系，为当前视图坐标系，不包含StatuBar和navigationBar***
      
        重新table视图的高度
        计算公式为:当前视图高度－键盘高度－inputArea高度

      */
    
    // 键盘高度
    CGFloat keyboardHeight = 0.0f;
    
    // 当前视图大小
    CGSize currentViewSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    
    // 键盘显示时间
    CGFloat animationDuration = [[[notification userInfo] valueForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];

    if ([[notification name] isEqualToString:UIKeyboardWillShowNotification]) {// 键盘显示时

        // 键盘大小
        NSValue *keyboardFrameValue = [[notification userInfo] valueForKey:UIKeyboardFrameEndUserInfoKey] ;
        CGRect keyboardRect = [keyboardFrameValue CGRectValue];
        keyboardHeight = keyboardRect.size.height;
 
    } else if ([[notification name] isEqualToString:UIKeyboardWillHideNotification]) {// 键盘隐藏时
        
        // 键盘大小
        keyboardHeight = 0.0f;
        
    }
    
    // 输入区域大小
    CGSize inputAreaSize = CGSizeMake(inputArea.frame.size.width, inputArea.frame.size.height);
    CGPoint inputAreaCenter =
    CGPointMake(inputAreaSize.width/2, currentViewSize.height-keyboardHeight-(inputAreaSize.height/2));
    
    // 新计算聊天纪录显示区域大小
    CGFloat chattingTableViewWidth = chattingTableView.frame.size.width;
    CGRect chattingTableViewframe =
    CGRectMake(0, 0, chattingTableViewWidth, currentViewSize.height-keyboardHeight-inputAreaSize.height);
    
    // 使用动画效果调整布局
    [UIView animateWithDuration:animationDuration animations:^(void){
        inputArea.center = inputAreaCenter;
        chattingTableView.frame = chattingTableViewframe;
    }];

    
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [chattingHistory count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSUInteger row = [indexPath row];
//    
//    NSDictionary *chatData = [chattingHistory objectAtIndex:row];
//    NSString *key = [[chatData allKeys] lastObject];
//    
//    NSString *tmpWords = [[chatData valueForKey:key] words];
//    
//    CGSize wordsSize = [tmpWords sizeWithFont:[UIFont systemFontOfSize:16.0f]
//                         constrainedToSize:CGSizeMake(200.0f, 2000.0f)
//                             lineBreakMode:UILineBreakModeWordWrap];
    
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"BubbleCell";
    BubbleCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"BubbleCell" owner:self options:nil];
        cell = self.bubbleCell;
        self.bubbleCell = nil;
    }
    
    NSUInteger row = [indexPath row];
    
    NSDictionary *chatData = [chattingHistory objectAtIndex:row];
    NSString *key = [[chatData allKeys] lastObject];
    
    [cell setWords:[[chatData valueForKey:key] words] fromSelf:NO];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Text field delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark - Customed methods
- (IBAction)sendMessage:(id)sender
{
    ChattingData *newData = [[ChattingData alloc] initWithWords:[msgTextField text] Character:ChattingCharacterMe];
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:newData, ME, nil];
    
    [chattingHistory addObject:dict];
    [newData release];
    [dict release];
    
    [chattingTableView reloadData];
    [self scrollViewToEnd];
}

- (void)scrollViewToEnd
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[chattingHistory count]-1 inSection:0];
    
    [chattingTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}
@end
