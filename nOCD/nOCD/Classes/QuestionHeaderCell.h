//
//  QuestionHeaderCell.h
//  nOCD
//
//  Created by Admin on 7/13/15.
//  Copyright (c) 2015 MagicDevs. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QuestionHeaderCellDelegate <NSObject>

@optional
- (void)addedAnswer:(NSDictionary*)answerInfo;
- (void)editingAnswer:(NSDictionary*)answerInfo;
- (void)textFieldDidBeginEditing:(MDTextField *)textField;
- (void)textFieldDidEndEditing:(MDTextField *)textField;
@end


@interface QuestionHeaderCell : UITableViewCell

- (void)configureCellInfo:(NSDictionary*)info indexPath:(NSIndexPath*)indexPath;
- (float)calculateCellHeight:(NSDictionary*)info indexPath:(NSIndexPath*)indexPath;
- (void)editAnswer:(NSDictionary*)info;

- (IBAction)btnAddTap:(id)sender;

@property (nonatomic, assign) id <QuestionHeaderCellDelegate> delegate;
@end
