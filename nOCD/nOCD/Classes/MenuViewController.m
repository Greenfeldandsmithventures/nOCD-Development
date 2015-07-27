//
//  MenuViewController.m
//  nOCD
//
//  Created by Admin on 7/4/15.
//  Copyright (c) 2015 MagicDevs. All rights reserved.
//

#import "MenuViewController.h"
#import "MyDataViewController.h"
#import "ConnectWatchViewController.h"

@interface MenuViewController ()<UITableViewDataSource,UITableViewDelegate> {
    
    __weak IBOutlet UITableView *tblMenu;
    __weak IBOutlet UIView *viewHeader;
    __weak IBOutlet UIImageView *imgAvatar;
    __weak IBOutlet UIImageView *imgBgAvatar;
    __weak IBOutlet UILabel *lblName;
    
    NSArray *arrMenu;
}

@end

@implementation MenuViewController

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
    //    imgBgAvatar.image = [MDManager cropImageAndScale:CGRectMake(0, 0, imgBgAvatar.frame.size.width, imgBgAvatar.frame.size.height) originalImage:imgBgAvatar.image];
    //    imgAvatar.image = [MDManager cropImageAndScale:CGRectMake(0, 0, imgAvatar.frame.size.width, imgAvatar.frame.size.height) originalImage:imgAvatar.image];
    imgBgAvatar.image = [[MDManager sharedInstance] blurWithCoreImage:imgBgAvatar.image inView:imgBgAvatar];
    imgAvatar.clipsToBounds = YES;
    imgAvatar.layer.borderColor = [UIColor whiteColor].CGColor;
    imgAvatar.layer.borderWidth = 2.0f;
    imgAvatar.layer.cornerRadius = imgAvatar.frame.size.height/2;
    
    lblName.font = [UIFont fontWithName:lblName.font.fontName size:lblName.font.pointSize*deviceScale];
    lblName.text = [NSString stringWithFormat:@"%@ %@",[DictionaryManager get_String_From_Dictionary:[AppManager sharedInstance].userInfo key:@"firstName"],[DictionaryManager get_String_From_Dictionary:[AppManager sharedInstance].userInfo key:@"lastName"]];
    arrMenu = @[@"My Activity",
                @"My Data",
                @"Self Analysis",
                @"ERP Homework",
                @"Connect Watch",
                @"Settings"];
    [tblMenu reloadData];
}

- (IBAction)btnLogOutTap:(id)sender {
    [AppManager sharedInstance].userInfo = nil;
    [AppManager sharedInstance].isLogedin = NO;
    [[AppManager sharedInstance] saveSettings];
    [self dismissViewControllerAnimated:YES completion:^{}];
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return 53.0f*deviceScale;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 6;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MenuCell"];
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"menuCell_%d",(int)indexPath.row]];
    cell.textLabel.text = arrMenu[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
                UINavigationController *nc = (UINavigationController *)self.mm_drawerController.centerViewController;
                [nc popToRootViewControllerAnimated:NO];
            }];
        }
            break;
        case 1:
            [self openMyData];
            break;
        case 4:
            [self openConnectToWatch];
            break;
        default:
            break;
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

- (void)openMyActivity {
    
}

- (void)openMyData {
    MyDataViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MyDataViewController"];
    [[AppManager sharedInstance] openViewController:self :viewController];
}

- (void)openConnectToWatch {
    ConnectWatchViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ConnectWatchViewController"];
    [[AppManager sharedInstance] openViewController:self :viewController];
}

@end
