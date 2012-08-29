//
//  FriendsGroupViewController.h
//  QQList
//
//  Created by ly on 8/27/12.
//  Copyright (c) 2012 ly. All rights reserved.
//

#import <UIKit/UIKit.h>

#define GROUP_EXPANDED_STATE (@"Group_Expanded")
#define GROUP_UNEXPANDED_STATE (@"Group_Unexpanded")

@class SectionHeaderView;
@class GroupTableViewCell;
@interface FriendsGroupViewController : UITableViewController
{
    NSMutableDictionary *groupAndNames;
    NSMutableArray *groupTitles;
    NSMutableArray *groupStates;
    
    UIImage *expandedImage;
    UIImage *unexpandedImage;
    
    IBOutlet SectionHeaderView *sectionHeaderView;
}

@property (nonatomic, retain) UINib *sectionHeaderNib;
@property (nonatomic, retain) UINib *cellNib;
@property (nonatomic, retain) IBOutlet SectionHeaderView *sectionHeaderView;
@property (retain, nonatomic) IBOutlet GroupTableViewCell *groupTableViewCell;

- (IBAction)expandOrShrink:(id)sender;


@end
