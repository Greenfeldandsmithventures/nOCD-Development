//
//  QuestionsView.m
//  nOCD
//
//  Created by Admin on 7/7/15.
//  Copyright (c) 2015 MagicDevs. All rights reserved.
//

#import "QuestionsView.h"
#import "QuestionHeaderCell.h"

@interface QuestionsView ()<UITableViewDataSource,UITableViewDelegate,MDTextFieldDelegate,QuestionHeaderCellDelegate> {
    __weak IBOutlet UITableView *tblAnswers;
    
    CGRect tableViewFrame;
 
    NSMutableArray *arrQuestionsInfo;
    
    MDTextField *activeTextField;
}

@end

@implementation QuestionsView

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)hideKeyBoard {
    [activeTextField resignFirstResponder];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (CGRectEqualToRect(tableViewFrame, CGRectZero)) {
         tableViewFrame = tblAnswers.frame;
    }
}

- (void)configureTableInfo:(NSArray*)arrInfo {
    arrQuestionsInfo = [arrInfo mutableCopy];
    [tblAnswers reloadData];
}

- (NSArray*)answersArray {
    NSMutableArray *arrTmp = [NSMutableArray new];
    for (int i = 0; i < arrQuestionsInfo.count; i ++) {
    NSDictionary *questionInfo = arrQuestionsInfo[i];
    if ([[DictionaryManager get_String_From_Dictionary:questionInfo key:@"type"] isEqualToString:@"answer"]) {
        [arrTmp addObject:questionInfo];
    }
        }
    return arrTmp;
}

- (NSDictionary*)answersWithHeaders {
    NSMutableArray *arrTmp = [NSMutableArray new];
    for (int i = 0; i < arrQuestionsInfo.count; i ++) {
        NSDictionary *questionInfo = arrQuestionsInfo[i];
        if ([[DictionaryManager get_String_From_Dictionary:questionInfo key:@"type"] isEqualToString:@"answer"]) {
            [arrTmp addObject:questionInfo];
        }
    }
    NSMutableDictionary *dictHeaders = [NSMutableDictionary new];
        for (int i = 0; i < arrTmp.count; i ++) {
            NSDictionary *dictHeader = arrTmp[0];
            NSArray *arrFilter = [arrTmp filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"headerTitle == %@",dictHeader[@"headerTitle"]]];
            dictHeaders[dictHeader[@"headerTitle"]] = [arrFilter valueForKey:@"title"];
            [arrTmp removeObjectsInArray:arrFilter];
            i = -1;
        }
    
    return dictHeaders;
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *questionInfo = arrQuestionsInfo[indexPath.row];
    if ([[DictionaryManager get_String_From_Dictionary:questionInfo key:@"type"] isEqualToString:@"header"]) {
        QuestionHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HeaderCell"];
        return [cell calculateCellHeight:questionInfo indexPath:indexPath];
    }
    
    return 30.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arrQuestionsInfo.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *questionInfo = arrQuestionsInfo[indexPath.row];
    if ([[DictionaryManager get_String_From_Dictionary:questionInfo key:@"type"] isEqualToString:@"header"]) {
        QuestionHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HeaderCell"];
        cell.delegate = self;
        [cell configureCellInfo:questionInfo indexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AnswerCell"];
    cell.textLabel.text = [DictionaryManager get_String_From_Dictionary:questionInfo key:@"title"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableDictionary *questionInfo = [arrQuestionsInfo[indexPath.row] mutableCopy];
    if ([[DictionaryManager get_String_From_Dictionary:questionInfo key:@"type"] isEqualToString:@"answer"]) {
        questionInfo[@"index"] = @(indexPath.row);
        [self findHeaderCell:indexPath answerInfo:questionInfo];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0000001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0000001;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [arrQuestionsInfo removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *questionInfo = arrQuestionsInfo[indexPath.row];
    if ([[DictionaryManager get_String_From_Dictionary:questionInfo key:@"type"] isEqualToString:@"header"]) {
        return NO;
    }
    return YES;
}

- (void)findHeaderCell:(NSIndexPath*)indexPath answerInfo:(NSDictionary*)answerInfo{
    NSDictionary *questionInfo = arrQuestionsInfo[indexPath.row-1];
    if ([[DictionaryManager get_String_From_Dictionary:questionInfo key:@"type"] isEqualToString:@"header"]) {
        QuestionHeaderCell *cell = (QuestionHeaderCell*)[tblAnswers cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row-1 inSection:0]];
        [cell editAnswer:answerInfo];
    } else {
        [self findHeaderCell:[NSIndexPath indexPathForRow:indexPath.row-1 inSection:0] answerInfo:answerInfo];
    }
}

#pragma mark - MDTextFieldDelegate

- (void)textFieldDidBeginEditing:(MDTextField *)textField {
    activeTextField = textField;
    [self ConfigureKeyBoard];
}

- (void)textFieldDidEndEditing:(MDTextField *)textField {
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)ConfigureKeyBoard {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                                           selector:@selector(keyboardDidShow:)
                                                               name:UIKeyboardDidShowNotification
                                                             object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
}

- (void)keyboardDidShow: (NSNotification *) notif{
    // Do something here
    NSDictionary* info = [notif userInfo];
    NSValue* aValue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardFrame = [aValue CGRectValue];
    
    CGRect frame = tableViewFrame;
    frame.size.height = screenHeight - keyboardFrame.size.height - self.frame.origin.y - 84.0f;
    tblAnswers.frame = frame;
}

- (void)keyboardDidHide: (NSNotification *) notif{
    // Do something here
    tblAnswers.frame = tableViewFrame;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - QuestionHeaderCellDelegate
- (void)addedAnswer:(NSDictionary *)answerInfo {
    int index = (int)[DictionaryManager get_int_From_Dictionary:answerInfo key:@"headerIndex"]+1;
    NSMutableArray *arrTmp = [[arrQuestionsInfo subarrayWithRange:NSMakeRange(0, index)] mutableCopy];
    [arrTmp addObject:answerInfo];
    [arrTmp addObjectsFromArray:[arrQuestionsInfo subarrayWithRange:NSMakeRange(index, arrQuestionsInfo.count - index)]];
    arrQuestionsInfo = [arrTmp mutableCopy];
    [tblAnswers reloadData];
}

- (void)editingAnswer:(NSDictionary *)answerInfo {
    int index = (int)[DictionaryManager get_int_From_Dictionary:answerInfo key:@"index"];
    [arrQuestionsInfo replaceObjectAtIndex:index withObject:answerInfo];
    [tblAnswers reloadData];
}
@end
