//
//  ObsessionsController.m
//  nOCD
//
//  Created by Admin on 7/27/15.
//  Copyright (c) 2015 MagicDevs. All rights reserved.
//

#import "ObsessionsController.h"

@interface ObsessionsController ()<UITableViewDataSource,UITableViewDelegate> {
    
    __weak IBOutlet UILabel *lblTitle;
    __weak IBOutlet UIView *viewHeader;
    __weak IBOutlet MDPopupButton *btnProcess;
    __weak IBOutlet UITableView *tblObsessions;
    
    NSInteger selectedIndex;
    
    NSArray *arrInfo;
}

@end

@implementation ObsessionsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (IBAction)btnBackTap:(id)sender {
}

- (void)configureViews {
    [[AppManager sharedInstance] scaleFontSizes:viewHeader];
    [btnProcess setTitle:@"PROCEED TO EXPOSURE" forState:UIControlStateNormal rightImage:[UIImage imageNamed:@"arrowRight"]];
    selectedIndex = -1;
    arrInfo = @[@"a",
                @"b",
                @"c"];
    [tblObsessions reloadData];
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return 44.0f*deviceScale;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return arrInfo.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ObsessionCell"];
    if (selectedIndex == indexPath.row) {
        cell.imageView.image = [UIImage imageNamed:@"imgChecked"];
    } else {
        cell.imageView.image = nil;
    }
    
    cell.textLabel.text = arrInfo[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *arrIndexPaths ;
    if (selectedIndex >= 0) {
        arrIndexPaths = @[[NSIndexPath indexPathForRow:selectedIndex inSection:0],indexPath];
    } else {
        arrIndexPaths = @[indexPath];
    }
    selectedIndex = indexPath.row;
    [tableView reloadRowsAtIndexPaths:arrIndexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
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
@end
