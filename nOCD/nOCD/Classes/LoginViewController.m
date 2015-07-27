//
//  LoginViewController.m
//  nOCD
//
//  Created by Admin on 7/3/15.
//  Copyright (c) 2015 MagicDevs. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "ForgotPasController.h"

@interface LoginViewController ()<MDTextFieldDelegate> {
    
    __weak IBOutlet UILabel *lblTitle;
    __weak IBOutlet UIButton *btnSignIn;
    __weak IBOutlet MDTextField *txtUserName;
    __weak IBOutlet MDTextField *txtPassword;
    MDTextField *activeTextField;
    UIFont *textFieldFont;
}

@end

@implementation LoginViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.view.userInteractionEnabled = YES;
    if ([AppManager sharedInstance].isLogedin) {
        [[AppManager sharedInstance] login:self];
    }
}

- (void)configureViews {
    self.view.userInteractionEnabled = NO;
    //nOCD Title
    NSMutableAttributedString *strTitle = [[NSMutableAttributedString alloc] initWithString:lblTitle.text];    
    [strTitle addAttributes:@{NSFontAttributeName :[UIFont fontWithName:@"GothamMedium" size:61.0f*deviceScale]} range:NSMakeRange(0, 1)];
    [strTitle addAttributes:@{NSFontAttributeName :[UIFont fontWithName:@"GothamBold" size:61.0f*deviceScale]} range:NSMakeRange(1, lblTitle.text.length-1)];
    [lblTitle setAttributedText:strTitle];
    
    [txtUserName setValue:[UIColor whiteColor]
        forKeyPath:@"_placeholderLabel.textColor"];
    [txtPassword setValue:[UIColor whiteColor]
               forKeyPath:@"_placeholderLabel.textColor"];
    
    btnSignIn.layer.borderColor = [UIColor whiteColor].CGColor;
    btnSignIn.layer.borderWidth = 2.0f;
    btnSignIn.layer.cornerRadius = 5.0f;
 
    txtUserName.mddelegate = self;
    txtPassword.mddelegate = self;
    textFieldFont = txtUserName.font;
    
    [self disableSignInButton];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoard:)];
    [self.view addGestureRecognizer:singleTap];
}

- (void)hideKeyBoard:(UITapGestureRecognizer *)sender  {
    [activeTextField resignFirstResponder];
}

- (IBAction)btnHelpTap:(id)sender {
}

- (IBAction)btnSignInTap:(id)sender {
    [activeTextField resignFirstResponder];
    MDLoadingView *loading = [[MDLoadingView alloc] initWithLabel:@"Please wait.."];
    [loading show];
    [MDWebServiceManager userlogin:txtUserName.text password:txtPassword.text completion:^(id response, NSError *error) {
        [loading hide];
        NSLog(@"%@", [response JSONString]);
        int status = (int)[DictionaryManager get_int_From_Dictionary:response key:@"status"];
        if (status == 1) {
            [[DateBaseManager sharedInstance] saveResponseInfo:[DictionaryManager get_Dictionary_From_Dictionary:response key:@"info"]];
            [AppManager sharedInstance].userInfo = [DictionaryManager get_Dictionary_From_Dictionary:response key:@"info"];
            [AppManager sharedInstance].isLogedin = YES;
            [[AppManager sharedInstance] saveSettings];
            [[AppManager sharedInstance] login:self];
            txtPassword.text = @"";
            txtUserName.text = @"";
        } else {
            [MDManager showAlert:[DictionaryManager get_String_From_Dictionary:response key:@"msg"]];
        }
        
    }];
}

- (IBAction)btnCreateAnAccountTap:(id)sender {
    RegisterViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"RegisterViewController"];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (IBAction)btnForgotPassTap:(id)sender {
    ForgotPasController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ForgotPasController"];
    [self.navigationController pushViewController:viewController animated:YES];
}

-(void)checkValidations:(MDTextField *)textField {
    
    if (txtUserName.text.length < 4) {
        [self disableSignInButton];
        txtUserName.textColor = wrongTextColor;
        return;
    } else {
        txtUserName.textColor = [UIColor whiteColor];
    }
    
    
    if (txtPassword.text.length < 4) {
        [self disableSignInButton];
        txtPassword.textColor = wrongTextColor;
        return;
    } else {
        txtPassword.textColor = [UIColor whiteColor];
        [self enableSignInButton];
    }
}

- (void)enableSignInButton {
    btnSignIn.enabled = YES;
    btnSignIn.layer.borderColor = [UIColor whiteColor].CGColor;
    [btnSignIn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnSignIn.layer.borderWidth = 2.0f;
    btnSignIn.layer.cornerRadius = 5.0f;
    btnSignIn.backgroundColor = [UIColor clearColor];
}

- (void)disableSignInButton {
    btnSignIn.enabled = NO;
    btnSignIn.layer.borderColor = [UIColor whiteColor].CGColor;
    [btnSignIn setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
    btnSignIn.layer.borderWidth = 2.0f;
    btnSignIn.layer.cornerRadius = 5.0f;
    btnSignIn.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.3f];
}
#pragma mark - MDTextFieldDelegate

- (void)textFieldDidBeginEditing:(MDTextField *)textField {
    activeTextField = (MDTextField*)textField;
    activeTextField.font = [UIFont fontWithName:@"GothamBold" size:textFieldFont.pointSize];
    
}

- (void)textFieldDidEndEditing:(MDTextField *)textField {
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
@end
