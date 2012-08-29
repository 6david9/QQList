//
//  ChatViewController.m
//  QQList
//
//  Created by ly on 8/27/12.
//  Copyright (c) 2012 ly. All rights reserved.
//

#import "ChatViewController.h"
#import "BubbleCell.h"

@interface ChatViewController ()

@end

@implementation ChatViewController
@synthesize bubbleCell;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    chattHistory = [[NSMutableArray alloc] initWithCapacity:10];

    @autoreleasepool {
        
        for (NSUInteger i = 0; i < 10; i++) {
            
            NSDictionary *dict = nil;
            
            if (i % 2 == 0) {   // 奇数行
                
                dict = [[NSDictionary alloc] initWithObjectsAndKeys:@"me:bla bla bla", ME, nil];
                
            } else {            // 偶数行
                
                dict = [[NSDictionary alloc] initWithObjectsAndKeys:@"other:bla bla bla", OTHER, nil];
                
            }
            
            [chattHistory addObject:dict];
        }
        
    }
    
}

- (void)viewDidUnload
{
    [self setBubbleCell:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [chattHistory count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"BubbleCell";
    BubbleCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
//        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
//                                       reuseIdentifier:CellIdentifier] autorelease];
        [[NSBundle mainBundle] loadNibNamed:@"BubbleCell" owner:self options:nil];
        cell = self.bubbleCell;
        self.bubbleCell = nil;
    }
    
    NSUInteger row = [indexPath row];
    NSDictionary *chattingDict = [chattHistory objectAtIndex:row];
    
    NSString *key = (row % 2 == 0) ? ME : OTHER;
//    [cell.textLabel setText:[chattingDict valueForKey:key]];
    [cell setWords:[chattingDict valueForKey:key] fromSelf:NO];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark Text field delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.2 animations:^(void){
        
        CGRect tableFrame = CGRectMake(myTableView.frame.origin.x,
                                       myTableView.frame.origin.y,
                                       myTableView.frame.size.width,
                                       149);
        [myTableView setFrame:tableFrame];
        

        NSIndexPath *indexpath = [NSIndexPath indexPathForRow:[chattHistory count]-1 inSection:0];
        [myTableView scrollToRowAtIndexPath:indexpath
                           atScrollPosition:UITableViewScrollPositionBottom
                                   animated:YES];
        
        
        CGPoint inputViewCenter = CGPointMake(myInputView.center.x, 174);
        [myInputView setCenter:inputViewCenter];
        
    }];
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    [UIView animateWithDuration:0.2 animations:^(void){
        
        CGRect tableFrame = CGRectMake(myTableView.frame.origin.x,
                                       myTableView.frame.origin.y,
                                       myTableView.frame.size.width,
                                       365);
        [myTableView setFrame:tableFrame];
        
        
        NSIndexPath *indexpath = [NSIndexPath indexPathForRow:[chattHistory count]-1 inSection:0];
        [myTableView scrollToRowAtIndexPath:indexpath
                           atScrollPosition:UITableViewScrollPositionBottom
                                   animated:YES];
        
        
        CGPoint inputViewCenter = CGPointMake(myInputView.center.x, 390);
        [myInputView setCenter:inputViewCenter];
    
    }];
    
    return YES;
}



- (void)dealloc {
    [bubbleCell release];
    [super dealloc];
}
@end
