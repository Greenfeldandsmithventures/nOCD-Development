//
//  QuestionHeaderCell.m
//  nOCD
//
//  Created by Admin on 7/13/15.
//  Copyright (c) 2015 MagicDevs. All rights reserved.
//

#import "QuestionHeaderCell.h"

@interface QuestionHeaderCell ()<MDTextFieldDelegate> {
    
    __weak IBOutlet UILabel *lblHeader;
    __weak IBOutlet MDTextField *txtAnswer;
    __weak IBOutlet UIView *viewLine;
    __weak IBOutlet UIButton *btnAdd;
    __weak IBOutlet UILabel *lblExample;
    
    NSDictionary *questionInfo;
    
    BOOL editing;
    NSMutableDictionary *editedInfo;
}

@end

@implementation QuestionHeaderCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    btnAdd.layer.borderColor = [UIColor whiteColor].CGColor;
    btnAdd.layer.borderWidth = 2.0f;
    btnAdd.layer.cornerRadius = 5.0f;
    
    txtAnswer.mddelegate = self;
    editing = NO;
    lblExample.numberOfLines = 0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)prepareForReuse {
    [super prepareForReuse];
    lblExample.text = @"";
}

- (void)configureCellInfo:(NSDictionary*)info indexPath:(NSIndexPath*)indexPath{
    questionInfo = info;
    lblHeader.text = [DictionaryManager get_String_From_Dictionary:info key:@"title"];
    [lblHeader sizeToFit];
    
    CGRect frame = txtAnswer.frame;
    frame.origin.y = lblHeader.frame.origin.y + lblHeader.frame.size.height;
    txtAnswer.frame = frame;
    NSString *placeholder = [DictionaryManager get_String_From_Dictionary:info key:@"placeholder"];
    if (placeholder.length > 0) {
        txtAnswer.placeholder = placeholder;
    }
    
    frame = viewLine.frame;
    frame.origin.y = txtAnswer.frame.origin.y + txtAnswer.frame.size.height - 3.0f;
    viewLine.frame = frame;
    
    frame = btnAdd.frame;
    frame.origin.y = txtAnswer.frame.origin.y;
    btnAdd.frame = frame;
    btnAdd.tag = indexPath.row;
    
    lblExample.text = [DictionaryManager get_String_From_Dictionary:info key:@"example"];
    [lblExample sizeToFit];
    
    frame = lblExample.frame;
    frame.origin.y = viewLine.frame.origin.y + viewLine.frame.size.height + 3.0f;
    lblExample.frame = frame;
}

- (float)calculateCellHeight:(NSDictionary*)info indexPath:(NSIndexPath*)indexPath{
    [self configureCellInfo:info indexPath:indexPath];
    float height = lblExample.frame.origin.y + lblExample.frame.size.height + 10.0f;
    return height;
}

- (IBAction)btnAddTap:(id)sender {
    if (txtAnswer.text.length > 0) {
        NSString *strID = [DictionaryManager get_String_From_Dictionary:questionInfo key:@"id"];
        if (strID.length == 0) {
            strID = [MDManager generateGUID];
        }
        if (editing) {
            editing = NO;
            editedInfo[@"title"] = txtAnswer.text;
            if ([self.delegate respondsToSelector:@selector(editingAnswer:)]) {
                [self.delegate editingAnswer:editedInfo];
            }
        }else {
            if ([self.delegate respondsToSelector:@selector(addedAnswer:)]) {
                [self.delegate addedAnswer:@{@"title":txtAnswer.text,
                                             @"type":@"answer",
                                             @"headerIndex":@(btnAdd.tag),
                                             @"id":strID,
                                             @"headerTitle":[DictionaryManager get_String_From_Dictionary:questionInfo key:@"headerTitle"]}];
            }
        }
        txtAnswer.text = @"";
        [txtAnswer resignFirstResponder];
    }
}

- (void)editAnswer:(NSDictionary*)info {
    txtAnswer.text = [DictionaryManager get_String_From_Dictionary:info key:@"title"];
    [txtAnswer becomeFirstResponder];
    editing = YES;
    editedInfo = [info mutableCopy];
}

#pragma mark - MDTextFieldDelegate

- (void)textFieldDidBeginEditing:(MDTextField *)textField {
    if ([self.delegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        [self.delegate textFieldDidBeginEditing:textField];
    }
}

- (void)textFieldDidEndEditing:(MDTextField *)textField {
    if ([self.delegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
        [self.delegate textFieldDidEndEditing:textField];
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self btnAddTap:btnAdd];
    return YES;
}
     
@end
