//
//  ForgotPasController.m
//  nOCD
//
//  Created by Admin on 7/17/15.
//  Copyright (c) 2015 MagicDevs. All rights reserved.
//

#import "ForgotPasController.h"

@interface ForgotPasController ()<MDTextFieldDelegate,UIAlertViewDelegate> {
    
    __weak IBOutlet MDTextField *txtEmail;
    __weak IBOutlet UIButton *btnReset;
    MDTextField *activeTextField;
    UIFont *textFieldFont;
}

@end

@implementation ForgotPasController

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
    [txtEmail setValue:[UIColor whiteColor]
               forKeyPath:@"_placeholderLabel.textColor"];
    txtEmail.mddelegate = self;
    textFieldFont = txtEmail.font;
    
    [self disableResetButton];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoard:)];
    [self.view addGestureRecognizer:singleTap];
}

- (void)hideKeyBoard:(UITapGestureRecognizer *)sender  {
    [activeTextField resignFirstResponder];
}

- (IBAction)btnResetTap:(id)sender {
    [activeTextField resignFirstResponder];
    MDLoadingView *loading = [[MDLoadingView alloc] initWithLabel:@"Please wait.."];
    [loading show];
    [MDWebServiceManager resetPass:txtEmail.text completion:^(id response, NSError *error) {
        [loading hide];
        NSInteger status = [DictionaryManager get_int_From_Dictionary:response key:@"status"];
        if (status == 1) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"nOCD" message:@"New password was set and sent to user!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            alert.tag = 1;
            [alert show];
        } else {
            [MDManager showAlert:[DictionaryManager get_String_From_Dictionary:response key:@"msg"]];
        }
    }];
}

-(void)checkValidations:(MDTextField *)textField {
    if (txtEmail.text.length == 0 || (txtEmail.text.length > 0 && ![[MDManager sharedInstance] validateEmail:txtEmail.text])) {
        [self disableResetButton];
        txtEmail.textColor = wrongTextColor;
        return;
    } else {
        txtEmail.textColor = [UIColor whiteColor];
        [self enableResetButton];
    }
}

- (void)enableResetButton {
    btnReset.enabled = YES;
    btnReset.layer.borderColor = [UIColor whiteColor].CGColor;
    [btnReset setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnReset.layer.borderWidth = 2.0f;
    btnReset.layer.cornerRadius = 5.0f;
    btnReset.backgroundColor = [UIColor clearColor];
}

- (void)disableResetButton {
    btnReset.enabled = NO;
    btnReset.layer.borderColor = [UIColor whiteColor].CGColor;
    [btnReset setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
    btnReset.layer.borderWidth = 2.0f;
    btnReset.layer.cornerRadius = 5.0f;
    btnReset.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.3f];
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

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
