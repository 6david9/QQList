//
//  FriendsGroupViewController.m
//  QQList
//
//  Created by ly on 8/27/12.
//  Copyright (c) 2012 ly. All rights reserved.
//

#import "FriendsGroupViewController.h"
#import "SectionHeaderView.h"
#import "GroupTableViewCell.h"
#import "ChatViewController.h"

@interface FriendsGroupViewController ()

@end

@implementation FriendsGroupViewController
@synthesize sectionHeaderView;
@synthesize groupTableViewCell;

- (void)viewDidLoad
{
    
    [super viewDidLoad];
 
    // 初始化 groupAndNames
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"GroupNames" ofType:@"plist"];
    groupAndNames = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    
    // 初始化 groupTitles
    NSArray *groups = [groupAndNames allKeys];
    groupTitles = [[NSMutableArray alloc] initWithArray:groups];
    
    // 设置分组初始展开状态
    groupStates = [[NSMutableArray alloc] initWithCapacity:[groupTitles count]];
    for (NSUInteger i = 0; i < [groupTitles count]; i++) {
        [groupStates addObject:GROUP_UNEXPANDED_STATE];
    }
    
    // 加载分组展开或收缩时 button 的 image
    expandedImage = [[UIImage imageNamed:@"pressed.png"] retain];
    unexpandedImage = [[UIImage imageNamed:@"normal.png"] retain];
    
    // 设置视图标题
    self.title = @"QQ";
    
    
    //设置表格背景视图
    UIImage *backgroundImage = [UIImage imageNamed:@"bgd.png"];
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:backgroundImage];
    [self.tableView setBackgroundView:backgroundView];
    
    // 设置表格单元格分隔线
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    // 加载nib文件
    self.sectionHeaderNib = [UINib nibWithNibName:@"SectionHeaderView" bundle:nil];
    self.cellNib = [UINib nibWithNibName:@"GroupTableViewCell" bundle:nil];
    
}

- (void)viewDidUnload
{
    [groupAndNames release], groupAndNames = nil;
    [groupStates release], groupStates = nil;
    [groupTitles release], groupTitles = nil;
    
    [self setGroupTableViewCell:nil];
    [super viewDidUnload];
}

- (void)dealloc
{
    [groupAndNames release], groupAndNames = nil;
    [groupStates release], groupStates = nil;
    [groupTitles release], groupTitles = nil;
    
    [groupTableViewCell release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [groupTitles count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 如果当前分组为未展开状态
    // 返回 0
    NSString *groupState = [groupStates objectAtIndex:section];
    if ([groupState isEqual:GROUP_UNEXPANDED_STATE]) {
        return 0;
    }
    
    NSString *sectionTitle = [groupTitles objectAtIndex:section];
    NSArray *rowsInEachSection = [groupAndNames valueForKey:sectionTitle];
    NSUInteger numberOfRows = [rowsInEachSection count];

    return numberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    GroupTableViewCell *cell = (GroupTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil){
        [self.cellNib instantiateWithOwner:self options:nil];
        cell = self.groupTableViewCell;
        self.groupTableViewCell = nil;
    }
    
    NSString *sectionTitle = [groupTitles objectAtIndex:[indexPath section]];
    NSArray *rowsInEachSection = [groupAndNames valueForKey:sectionTitle];
    NSString *name = [rowsInEachSection objectAtIndex:[indexPath row]];
    
    [cell setCellImage:[UIImage imageNamed:@"online.png"]];
    [cell setCellName:name];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    SectionHeaderView *view = nil;
    
    [self.sectionHeaderNib instantiateWithOwner:self options:nil];
    view = sectionHeaderView;
    self.sectionHeaderView = nil;
    
    // 设置view的标题
    NSString *groupTitle = [groupTitles objectAtIndex:section];
    [view setGroupTitle:groupTitle];
    
    // 设置view中button的image
    NSString *currentButtonState = [groupStates objectAtIndex:section];
    
    if ([currentButtonState isEqual:GROUP_EXPANDED_STATE])    
        [view setGroupButtonImage:expandedImage];
    
    else
        [view setGroupButtonImage:unexpandedImage];
    
    // 设置view中button的tag
    [view setTagForSectionHeaderViewButton:section];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 36;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ChatViewController *chatViewController = [[ChatViewController alloc] initWithNibName:@"ChatViewController"
                                                                                  bundle:nil];
    
    [self.navigationController pushViewController:chatViewController animated:YES];
}

#pragma mark - Customed methods
- (IBAction)expandOrShrink:(id)sender
{
    UIButton *sectionButton = (UIButton *)sender;
    
    NSUInteger buttonSection = [sectionButton tag];
    NSString *currentButtonState = [groupStates objectAtIndex:buttonSection];
    
    if ([currentButtonState isEqual:GROUP_EXPANDED_STATE]) {
        
        [sectionButton setImage:unexpandedImage forState:UIControlStateNormal];
        [groupStates replaceObjectAtIndex:buttonSection withObject:GROUP_UNEXPANDED_STATE];
        
    } else {
        
        [sectionButton setImage:expandedImage forState:UIControlStateNormal];
        [groupStates replaceObjectAtIndex:buttonSection withObject:GROUP_EXPANDED_STATE];
        
    }
    
    // 更新分组状态后重新加载分组
    NSIndexSet *sectionIndexSet = [NSIndexSet indexSetWithIndex:buttonSection];
    [self.tableView reloadSections:sectionIndexSet withRowAnimation:UITableViewRowAnimationFade];
    
}
@end
