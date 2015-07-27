//
//  RegisterViewController.m
//  nOCD
//
//  Created by Admin on 7/7/15.
//  Copyright (c) 2015 MagicDevs. All rights reserved.
//

#import "RegisterViewController.h"
#import "QuestionsView.h"

typedef NS_OPTIONS(NSUInteger, warningTag) {
    EmailTag = 0,
    UserNameTag  = 1,
    PassTag  = 2
};

@interface RegisterViewController ()<MDTextFieldDelegate,UIScrollViewDelegate,UIGestureRecognizerDelegate,UIAlertViewDelegate> {
    UIButton *btnBack;
    __weak IBOutlet UIScrollView *scrlMain;
    __weak IBOutlet UIButton *btnNext;
    __weak IBOutlet UIView *viewGridBillingInfo;
    __weak IBOutlet UIView *viewGridQuestion1;
    __weak IBOutlet UILabel *lblQuestion1;
    
    __weak IBOutlet MDTextField *txtUserName;
    __weak IBOutlet MDTextField *txtPassword;
    __weak IBOutlet MDTextField *txtConfirmPassword;
    __weak IBOutlet MDTextField *txtFirstName;
    __weak IBOutlet MDTextField *txtLastName;
    __weak IBOutlet MDTextField *txtEmailAddress;
    
    __weak IBOutlet UIPageControl *pageControl;
    MDTextField *activeTextField;
    
    CGSize scrlMainContentSize;
    
    __weak IBOutlet UIButton *btnYes;
    __weak IBOutlet UIButton *btnNo;
    
    
    IBOutletCollection(UILabel) NSArray *arrLabels;
    
    __weak IBOutlet QuestionsView *viewObessions;
    __weak IBOutlet QuestionsView *viewTriggers;
    __weak IBOutlet QuestionsView *viewCompulsion;
    __weak IBOutlet QuestionsView *viewFavorites;
    
    UIFont *textFieldFont;
    
    NSMutableDictionary *regInfo;
    
    MDLoadingView *loading;
}

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureViews];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}

- (void)configureViews {
    
    regInfo = [NSMutableDictionary new];
    
    self.title = @"New Account";
    
    for (UILabel *lbl in arrLabels) {
        [lbl sizeToFit];
    }
    
    txtUserName.mddelegate = self;
    txtPassword.mddelegate = self;
    txtConfirmPassword.mddelegate = self;
    txtFirstName.mddelegate = self;
    txtLastName.mddelegate = self;
    txtEmailAddress.mddelegate = self;
    
    textFieldFont = txtUserName.font;
    
    btnBack = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    [btnBack setImage:[UIImage imageNamed:@"btnBack"] forState:UIControlStateNormal];
    [btnBack setTitle:@" Back" forState:UIControlStateNormal];
    btnBack.titleLabel.font = [UIFont fontWithName:@"GothamMedium" size:17.0f];
    [btnBack addTarget:self action:@selector(btnBackTap:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnBack];
    
    [self disableNextButton];
    
    NSArray *subviews = [scrlMain.subviews sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"tag" ascending:YES]]];
    float _x = 0;
    for (UIView *view in subviews) {
        if (!view.hidden) {
            view.frame = CGRectMake(_x, view.frame.origin.y, view.frame.size.width, view.frame.size.height);
            _x += view.frame.size.width;
            if ([view isKindOfClass:[UIButton class]]) {
                view.layer.borderColor = [UIColor whiteColor].CGColor;
                view.layer.borderWidth = 2.0f;
                view.layer.cornerRadius = 5.0f;
            }
        }
    }
    scrlMain.contentSize = CGSizeMake(_x, 0);
    
    [self configureButtonsLayers:viewGridBillingInfo];
    [self configureButtonsLayers:viewGridQuestion1];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoard:)];
    [scrlMain addGestureRecognizer:singleTap];
    singleTap.delegate = self;
    scrlMainContentSize = scrlMain.contentSize;
    
    [viewObessions configureTableInfo:@[@{@"title":@"What if",
                                          @"type":@"header",
                                          @"questionType":@"obsession",
                                          @"example":@"Ex: “What if I catch Ebola”"}]];
    [self configureFavorites];
    
    loading = [[MDLoadingView alloc] initWithLabel:@"Please wait..."];
}

#pragma mark UIGestureRecognizerDelegate methods

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    
    if ([touch.view isKindOfClass:[UILabel class]]) {
        
        // Don't let selections of auto-complete entries fire the
        // gesture recognizer
        return NO;
    }
    
    return YES;
}

- (void)hideKeyBoard:(UITapGestureRecognizer *)sender  {
    [activeTextField resignFirstResponder];
    [viewObessions hideKeyBoard];
    [viewTriggers hideKeyBoard];
    [viewCompulsion hideKeyBoard];
    [viewFavorites hideKeyBoard];
}

- (void)configureButtonsLayers:(UIView*)viewGrid {
    for (UIView *view in viewGrid.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            view.layer.borderColor = [UIColor whiteColor].CGColor;
            view.layer.borderWidth = 2.0f;
            view.layer.cornerRadius = 5.0f;
        }
    }
}

- (void)enableNextButton {
    btnNext.enabled = YES;
    btnNext.layer.borderColor = wrongTextColor.CGColor;
    [btnNext setTitleColor:wrongTextColor forState:UIControlStateNormal];
    btnNext.layer.borderWidth = 2.0f;
    btnNext.layer.cornerRadius = 5.0f;
    btnNext.backgroundColor = [UIColor clearColor];
}

- (void)disableNextButton {
    btnNext.enabled = NO;
    btnNext.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [btnNext setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    btnNext.layer.borderWidth = 2.0f;
    btnNext.layer.cornerRadius = 5.0f;
    btnNext.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.3f];
}

- (IBAction)btnBackTap:(id)sender {
    btnBack.userInteractionEnabled = NO;
    switch (btnBack.tag) {
        case 0:
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        default:
            [scrlMain setContentOffset:CGPointMake(scrlMain.bounds.origin.x - scrlMain.frame.size.width, scrlMain.contentOffset.y) animated:YES];
            [self hideKeyBoard:nil];
            break;
    }
    
}
- (IBAction)btnNextTap:(id)sender {
    [self createRegInfo:btnNext.tag];
    if (btnNext.tag < 6) {        
        btnNext.userInteractionEnabled = NO;
        [scrlMain setContentOffset:CGPointMake(scrlMain.bounds.origin.x + scrlMain.frame.size.width, scrlMain.contentOffset.y) animated:YES];
    } else {
        [self sendRegisterRequest];
    }
}

- (IBAction)btnBillTap:(id)sender {
    UIButton *btn = sender;
    btn.selected = YES;
    btn.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.3f];
    for (UIView *view in viewGridBillingInfo.subviews) {
        if ([view isKindOfClass:[UIButton class]] && view != btn) {
            view.backgroundColor = [UIColor clearColor];
            [(UIButton*)view setSelected:NO];
        }
    }
    [self enableNextButton];
}

- (IBAction)btnYesNoTap:(id)sender {
    if (sender == btnYes) {
        btnYes.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.3f];
        btnNo.backgroundColor = [UIColor clearColor];
        btnYes.selected = YES;
        btnNo.selected = NO;
    } else {
        btnYes.backgroundColor = [UIColor clearColor];
        btnNo.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.3f];
        btnYes.selected = NO;
        btnNo.selected = YES;
    }
    [self enableNextButton];
}

- (void)sendRegisterRequest {
    [loading show];
    [MDWebServiceManager userRegister:regInfo completion:^(id response, NSError *error) {
        [loading hide];
        NSInteger status = [DictionaryManager get_int_From_Dictionary:response key:@"status"];
        if (status == 1) {
            [AppManager sharedInstance].userInfo = [DictionaryManager get_Dictionary_From_Dictionary:response key:@"info"];
            [AppManager sharedInstance].isLogedin = YES;
            [[AppManager sharedInstance] saveSettings];
            [[AppManager sharedInstance] login:self];
        } else if(status == 2){
            [scrlMain setContentOffset:CGPointMake(0, scrlMain.contentOffset.y) animated:YES];;
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"nOCD" message:@"This email address is already exist!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            alert.tag = EmailTag;
            [alert show];
        }else if(status == 3){
            [scrlMain setContentOffset:CGPointMake(0, scrlMain.contentOffset.y) animated:YES];;
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"nOCD" message:@"This username is already exist!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            alert.tag = UserNameTag;
            [alert show];
        } else {
            [MDManager showAlert:[DictionaryManager get_String_From_Dictionary:response key:@"msg"]];
        }
    }];
}

- (void)createRegInfo:(NSInteger)index {
    switch (index) {
        case 0:
            regInfo[@"userName"] = txtUserName.text;
            regInfo[@"password"] = txtPassword.text;
            regInfo[@"firstName"] = txtFirstName.text;
            regInfo[@"lastName"] = txtLastName.text;
            regInfo[@"email"] = txtEmailAddress.text;
            break;
        case 1:
        {
            UIButton *btn;
            for (UIView *view in viewGridBillingInfo.subviews) {
                if ([view isKindOfClass:[UIButton class]]) {
                    btn = (UIButton*)view;
                    if (btn.selected) {
                        break;
                    }
                }
            }
            regInfo[@"paymentType"] = @(btn.tag +1);
            regInfo[@"payed"] = @(YES);
        }
            
            break;
        case 2:
        {
            regInfo[@"diagnosed"] = @(btnYes.selected);
        }
            break;
        case 3:
        {
            NSArray *arrObsessions = [viewObessions answersArray];
            regInfo[@"obsessions"] = [arrObsessions valueForKey:@"title"];
        }
            break;
        case 4:
        {
            NSDictionary *dictTriggers = [viewTriggers answersWithHeaders];
            regInfo[@"triggers"] = dictTriggers;
        }
            break;
        case 5:
        {
            NSDictionary *dictCompulsions = [viewCompulsion answersWithHeaders];
            regInfo[@"compulsions"] = dictCompulsions;
        }
            break;
        case 6:
        {
            NSDictionary *dictFavorites = [viewFavorites answersWithHeaders];
            regInfo[@"favorites"] = dictFavorites;
        }
            break;
            
        default:
            break;
    }
}

-(void)checkValidations:(MDTextField *)textField {
    
    if (txtUserName.text.length < 4) {
        [self disableNextButton];
        txtUserName.textColor = wrongTextColor;
        return;
    } else {
        txtUserName.textColor = [UIColor whiteColor];
    }
    
    
    if (txtPassword.text.length < 4 && txtPassword.text.length > 0) {
        [self disableNextButton];
        txtPassword.textColor = wrongTextColor;
        return;
    } else {
        txtPassword.textColor = [UIColor whiteColor];
    }
    
    if (![txtPassword.text isEqualToString:txtConfirmPassword.text]) {
        [self disableNextButton];
        txtConfirmPassword.textColor = wrongTextColor;
        return;
    } else {
        txtConfirmPassword.textColor = [UIColor whiteColor];
    }
    
    if (txtEmailAddress.text.length == 0 || (txtEmailAddress.text.length > 0 && ![[MDManager sharedInstance] validateEmail:txtEmailAddress.text])) {
        [self disableNextButton];
        txtEmailAddress.textColor = wrongTextColor;
        return;
    } else {
        txtEmailAddress.textColor = [UIColor whiteColor];
        [self enableNextButton];
    }
}

- (void)checkNextStatus:(int)index {
    
    self.title = @"New Account";
    
    [btnNext setTitle:@"NEXT" forState:UIControlStateNormal];
    [btnNext setTitle:@"NEXT" forState:UIControlStateDisabled];
    switch (index) {
        case 0:
            [self checkValidations:txtEmailAddress];
            break;
        case 1:
        {
            [self disableNextButton];
            for (UIView *view in viewGridBillingInfo.subviews) {
                if ([view isKindOfClass:[UIButton class]]) {
                    UIButton *btn = (UIButton*)view;
                    if (btn.selected) {
                        [self enableNextButton];
                        break;
                    }
                }
            }
        }
            break;
        case 2:
        {
            if (!btnYes.selected && !btnNo.selected) {
                [self disableNextButton];
            } else {
                [self enableNextButton];
            }
            self.title = @"Question 1 / 5";
        }
            break;
        case 3:
            self.title = @"Question 2 / 5";
            break;
        case 4:
            self.title = @"Question 3 / 5";
            [self configureTriggers];
            break;
        case 5:
            self.title = @"Question 4 / 5";
            [self configureCompulsions];
            break;
            //        case 6:
            //            self.title = @"Question 4 / 5";
            //            break;
        case 6:
        {
            self.title = @"Question 5 / 5";
            
            [btnNext setTitle:@"DONE" forState:UIControlStateNormal];
            [btnNext setTitle:@"DONE" forState:UIControlStateDisabled];
        }
        default:
            break;
    }
}

- (void)configureTriggers {
    NSMutableArray *arrTriggers = [NSMutableArray new];
    NSArray *arrObsessions = [viewObessions answersArray];
    NSArray *arrTmpTriggers = [viewTriggers answersArray];
    for (int i = 0; i < arrObsessions.count; i ++) {
        NSDictionary *obsession = arrObsessions[i];
        NSDictionary *trigger = @{@"title":[NSString stringWithFormat:@"My Obsession ”What if %@” is triggered by",[DictionaryManager get_String_From_Dictionary:obsession key:@"title"]],
                                  @"type":@"header",
                                  @"questionType":@"trigger",
                                  @"id":[DictionaryManager get_String_From_Dictionary:obsession key:@"id"],
                                  @"example":@"Ex: My Obsession, ”What if I have Ebola” , is triggered by ”Airport bathrooms”.",
                                  @"headerTitle":[DictionaryManager get_String_From_Dictionary:obsession key:@"title"]};
        NSArray *arrTriggerAnswers = [arrTmpTriggers filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"id = %@",[DictionaryManager get_String_From_Dictionary:obsession key:@"id"]]];
        [arrTriggers addObject:trigger];
        [arrTriggers addObjectsFromArray:arrTriggerAnswers];
    }
    [viewTriggers configureTableInfo:arrTriggers];
}

- (void)configureCompulsions {
    //
    NSMutableArray *arrCompulsions = [NSMutableArray new];
    NSArray *arrObsessions = [viewObessions answersArray];
    NSArray *arrTmpCompulsions = [viewCompulsion answersArray];
    for (int i = 0; i < arrObsessions.count; i ++) {
        NSDictionary *obsession = arrObsessions[i];
        NSDictionary *compulsion = @{@"title":[NSString stringWithFormat:@"My obsessional theme, ”What if %@”",[DictionaryManager get_String_From_Dictionary:obsession key:@"title"]],
                                     @"type":@"header",
                                     @"questionType":@"compulsion",
                                     @"id":[DictionaryManager get_String_From_Dictionary:obsession key:@"id"],
                                     @"example":@"Ex: “Checking,”",
                                     @"headerTitle":[DictionaryManager get_String_From_Dictionary:obsession key:@"title"]};
        NSArray *arrCompulsionAnswers = [arrTmpCompulsions filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"id = %@",[DictionaryManager get_String_From_Dictionary:obsession key:@"id"]]];
        [arrCompulsions addObject:compulsion];
        [arrCompulsions addObjectsFromArray:arrCompulsionAnswers];
    }
    [viewCompulsion configureTableInfo:arrCompulsions];
}

- (void)configureFavorites {
    NSArray *arrFavorites = @[@{@"title":@"",
                                @"type":@"header",
                                @"questionType":@"Hobbies",
                                @"headerTitle":@"hobbies",
                                @"id":[MDManager generateGUID],
                                @"placeholder":@"Add Favorite Hobbies",
                                @"example":@"Ex: “Listening to Music”"},
                              @{@"title":@"",
                                @"type":@"header",
                                @"questionType":@"Apps",
                                @"headerTitle":@"apps",
                                @"id":[MDManager generateGUID],
                                @"placeholder":@"Add Favorite Apps",
                                @"example":@"Ex: “Twitter”"},
                              @{@"title":@"",
                                @"type":@"header",
                                @"questionType":@"Tasks",
                                @"headerTitle":@"tasks",
                                @"id":[MDManager generateGUID],
                                @"placeholder":@"Add Favorite Tasks",
                                @"example":@"Ex: “Mowing the Lawn”"},
                              @{@"title":@"",
                                @"type":@"header",
                                @"questionType":@"Interests",
                                @"headerTitle":@"interests",
                                @"id":[MDManager generateGUID],
                                @"placeholder":@"Add Favorite Interests",
                                @"example":@"Ex: “Current Events”"}];
    [viewFavorites configureTableInfo:arrFavorites];
}

#pragma mark - MDTextFieldDelegate

- (void)textFieldDidBeginEditing:(MDTextField *)textField {
    activeTextField = (MDTextField*)textField;
    activeTextField.font = [UIFont fontWithName:@"GothamBold" size:textFieldFont.pointSize];
    CGSize ContentSize = scrlMainContentSize;
    ContentSize.height =screenHeight + 130.0f;
    ContentSize.width = 0;
    scrlMain.contentSize= ContentSize;
    scrlMain.scrollEnabled = YES;
    scrlMain.pagingEnabled = NO;
    [scrlMain setContentOffset:CGPointMake(scrlMain.contentOffset.x, textField.frame.origin.y +textField.superview.frame.origin.y - 130.0f) animated:YES];
}

- (void)textFieldDidEndEditing:(MDTextField *)textField {
    
    [scrlMain setContentOffset:CGPointMake(scrlMain.contentOffset.x, 0) animated:YES];
    textField.font = textFieldFont;
}

- (BOOL)textFieldShouldBeginEditing:(MDTextField *)textField {
    return YES;
}

- (void)textFieldDidChange:(MDTextField *)textField {
    [self checkValidations:textField];
}

- (BOOL)textFieldShouldReturn:(MDTextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    btnNext.userInteractionEnabled = YES;
    btnBack.userInteractionEnabled = YES;
    if (![activeTextField isFirstResponder]) {
        scrlMain.contentSize= scrlMainContentSize;
        scrlMain.scrollEnabled = NO;
        scrlMain.pagingEnabled = YES;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView != scrlMain||scrollView.contentSize.width != scrlMain.contentSize.width) {
        return;
    }
    CGFloat pageWidth = scrollView.bounds.size.width ;
    float fractionalPage = scrollView.contentOffset.x / pageWidth ;
    NSInteger nearestNumber = lround(fractionalPage);
    
    if (pageControl.currentPage != nearestNumber)
    {
        btnBack.tag = nearestNumber;
        btnNext.tag = nearestNumber;
        pageControl.currentPage = nearestNumber ;
        [self checkNextStatus:(int)nearestNumber];
        
        // if we are dragging, we want to update the page control directly during the drag
    }
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (alertView.tag) {
        case EmailTag: {
            [txtEmailAddress becomeFirstResponder];
            txtEmailAddress.textColor = wrongTextColor;
            [self disableNextButton];
        }
            break;
            case UserNameTag:
        {
            [txtUserName becomeFirstResponder];
            txtUserName.textColor = wrongTextColor;
            [self disableNextButton];
        }
        default:
            break;
    }
}
@end

