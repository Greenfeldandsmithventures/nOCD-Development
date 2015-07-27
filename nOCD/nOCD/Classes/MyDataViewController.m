//
//  MyDataViewController.m
//  nOCD
//
//  Created by Admin on 7/7/15.
//  Copyright (c) 2015 MagicDevs. All rights reserved.
//

#import "MyDataViewController.h"
#import "MyDataDetailViewController.h"

@interface MyDataViewController ()<UITableViewDataSource,UITableViewDelegate> {
    
    __weak IBOutlet UITableView *tblMyData;
    NSArray *arrMyData;
}

@end

@implementation MyDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureViews {
    [self createRightButton];
    self.title = @"My Data";
    
    arrMyData = @[@"View Frequency",
                  @"View Intensity",
                  @"View Places",
                  @"Time of Day",
                  @"View Length",
                  @"Time Spent Using nOCD",
                  @"Time Dedicated to OCD Episodes",
                  @"Avg VS. Goal Resistance Time",];
    [tblMyData reloadData];
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return 63.0f*deviceScale;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return arrMyData.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyDataCell"];
    cell.textLabel.text = arrMyData[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MyDataDetailViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MyDataDetailViewController"];
    [self.navigationController pushViewController:viewController animated:YES];
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
