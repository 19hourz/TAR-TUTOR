//
//  SignUpViewController.m
//  TAR TUTOR
//
//  Created by Jiasheng Zhu on 4/5/16.
//  Copyright © 2016 Jiasheng Zhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SignUpViewController.h"
@interface SignUpViewController()

@end

@implementation SignUpViewController

@synthesize appDelegate;

UITextField *emailTextField;
UITextField *passwordTextField;
UITextField *confirmPasswordTextField;
UITextField *codeTextField;
UITextField *nameTextField;
UIActivityIndicatorView* spinner;

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    //add a label
//    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*0.2, screenRect.size.height*0.12, screenRect.size.width*0.6, 50)];
//    label.text = @"TAR TUOR";
//    [label setTextAlignment:NSTextAlignmentCenter];
//    label.font = [UIFont systemFontOfSize:40];
    //    [self.view addSubview:label];
    
    //add verification text field
    nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.15, screenRect.size.height*0.2, screenRect.size.width*0.7, 31)];
    nameTextField.borderStyle = UITextBorderStyleNone;
    nameTextField.placeholder = @" Name";
    nameTextField.delegate = self;
    [nameTextField setKeyboardType:UIKeyboardTypeEmailAddress];
    [nameTextField setAutocorrectionType:UITextAutocorrectionTypeNo];
    [self.view addSubview:nameTextField];
    
    //add line below verification textfield
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(screenRect.size.width*0.15, screenRect.size.height*0.2 + 31)];
    [path addLineToPoint:CGPointMake(screenRect.size.width*0.85, screenRect.size.height*0.2 + 31)];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = [path CGPath];
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.lineWidth = 2.0;
    shapeLayer.fillColor = [[UIColor clearColor] CGColor];
    [self.view.layer addSublayer:shapeLayer];
    
    //add verification text field
    codeTextField = [[UITextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.15, screenRect.size.height*0.3, screenRect.size.width*0.7, 31)];
    codeTextField.borderStyle = UITextBorderStyleNone;
    codeTextField.placeholder = @" Verification Code";
    codeTextField.delegate = self;
    [codeTextField setKeyboardType:UIKeyboardTypeEmailAddress];
    [codeTextField setAutocorrectionType:UITextAutocorrectionTypeNo];
    [self.view addSubview:codeTextField];
    
    //add line below verification textfield
    UIBezierPath *path0 = [UIBezierPath bezierPath];
    [path0 moveToPoint:CGPointMake(screenRect.size.width*0.15, screenRect.size.height*0.3 + 31)];
    [path0 addLineToPoint:CGPointMake(screenRect.size.width*0.85, screenRect.size.height*0.3 + 31)];
    
    CAShapeLayer *shapeLayer0 = [CAShapeLayer layer];
    shapeLayer0.path = [path0 CGPath];
    shapeLayer0.strokeColor = [UIColor redColor].CGColor;
    shapeLayer0.lineWidth = 2.0;
    shapeLayer0.fillColor = [[UIColor clearColor] CGColor];
    [self.view.layer addSublayer:shapeLayer0];
    
    //add email text field
    emailTextField = [[UITextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.15, screenRect.size.height*0.4, screenRect.size.width*0.7, 31)];
    emailTextField.borderStyle = UITextBorderStyleNone;
    emailTextField.placeholder = @" Email";
    emailTextField.delegate = self;
    [emailTextField setKeyboardType:UIKeyboardTypeEmailAddress];
    [emailTextField setAutocorrectionType:UITextAutocorrectionTypeNo];
    [self.view addSubview:emailTextField];
    
    //add line below email textfield
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    [path1 moveToPoint:CGPointMake(screenRect.size.width*0.15, screenRect.size.height*0.4 + 31)];
    [path1 addLineToPoint:CGPointMake(screenRect.size.width*0.85, screenRect.size.height*0.4 + 31)];
    
    CAShapeLayer *shapeLayer1 = [CAShapeLayer layer];
    shapeLayer1.path = [path1 CGPath];
    shapeLayer1.strokeColor = [UIColor redColor].CGColor;
    shapeLayer1.lineWidth = 2.0;
    shapeLayer1.fillColor = [[UIColor clearColor] CGColor];
    [self.view.layer addSublayer:shapeLayer1];
    
    //add password text field
    passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.15, screenRect.size.height*0.5, screenRect.size.width*0.7, 31)];
    [passwordTextField setSecureTextEntry:YES];
    passwordTextField.borderStyle = UITextBorderStyleNone;
    passwordTextField.placeholder = @" Password";
    passwordTextField.delegate = self;
    [self.view addSubview:passwordTextField];
    
    //add line below email textfield
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    [path2 moveToPoint:CGPointMake(screenRect.size.width*0.15, screenRect.size.height*0.5 + 31)];
    [path2 addLineToPoint:CGPointMake(screenRect.size.width*0.85, screenRect.size.height*0.5 + 31)];
    
    CAShapeLayer *shapeLayer2 = [CAShapeLayer layer];
    shapeLayer2.path = [path2 CGPath];
    shapeLayer2.strokeColor = [UIColor redColor].CGColor;
    shapeLayer2.lineWidth = 2.0;
    shapeLayer2.fillColor = [[UIColor clearColor] CGColor];
    [self.view.layer addSublayer:shapeLayer2];
    
    //add password text field
    confirmPasswordTextField = [[UITextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.15, screenRect.size.height*0.6, screenRect.size.width*0.7, 31)];
    [confirmPasswordTextField setSecureTextEntry:YES];
    confirmPasswordTextField.borderStyle = UITextBorderStyleNone;
    confirmPasswordTextField.placeholder = @" Confirm password";
    confirmPasswordTextField.delegate = self;
    [self.view addSubview:confirmPasswordTextField];
    
    //add line below email textfield
    UIBezierPath *path3 = [UIBezierPath bezierPath];
    [path3 moveToPoint:CGPointMake(screenRect.size.width*0.15, screenRect.size.height*0.6 + 31)];
    [path3 addLineToPoint:CGPointMake(screenRect.size.width*0.85, screenRect.size.height*0.6 + 31)];
    
    CAShapeLayer *shapeLayer3 = [CAShapeLayer layer];
    shapeLayer3.path = [path3 CGPath];
    shapeLayer3.strokeColor = [UIColor redColor].CGColor;
    shapeLayer3.lineWidth = 2.0;
    shapeLayer3.fillColor = [[UIColor clearColor] CGColor];
    [self.view.layer addSublayer:shapeLayer3];
    
    //add sign in button
    UIButton *signUpButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    signUpButton.frame = CGRectMake(screenRect.size.width*0.2, screenRect.size.height*0.65 + 35, screenRect.size.width*0.6, 50);
    signUpButton.tag = 1;
    [signUpButton setTitle:@"Sign Up  " forState:UIControlStateNormal];
    [signUpButton.titleLabel setFont:[UIFont systemFontOfSize:20]];
    [signUpButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    signUpButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    signUpButton.layer.borderColor = [UIColor grayColor].CGColor;
    signUpButton.layer.borderWidth=1.0f;
    signUpButton.layer.cornerRadius = screenRect.size.width*0.4/10.0f;
    [signUpButton addTarget:self action:@selector(didTapButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:signUpButton];
    
    //add back button
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    backButton.frame = CGRectMake(screenRect.size.width*0.20, screenRect.size.height*0.75 + 50, screenRect.size.width*0.6, 50);
    backButton.tag = 2;
    [backButton setTitle:@"Back  " forState:UIControlStateNormal];
    [backButton.titleLabel setFont:[UIFont systemFontOfSize:20]];
    [backButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    backButton.layer.borderColor = [UIColor grayColor].CGColor;
    backButton.layer.borderWidth=1.0f;
    backButton.layer.cornerRadius = screenRect.size.width*0.4/10.0f;
    [backButton addTarget:self action:@selector(didTapButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    //add a spinner
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [spinner setCenter:CGPointMake(screenRect.size.width/2,  screenRect.size.height*0.625 + 30)];
    [self.view addSubview:spinner];
}

- (void)didTapButton:(UIButton *)button
{
    if(button.tag == 2){
        UIViewController* viewcontroller = [appDelegate.storyboard instantiateViewControllerWithIdentifier:@"SignInViewController"];
        [self presentViewController:viewcontroller animated:NO completion:nil];
    }
    else if(button.tag == 1){
        //sign up
        if(![passwordTextField.text isEqualToString:confirmPasswordTextField.text]){
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Different passwords" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:appDelegate.defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
            passwordTextField.text = @"";
            confirmPasswordTextField.text = @"";
            return;
        }
        else if(![codeTextField.text isEqualToString:@"WEARETARTUTORS"]){
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Invalid Verification code" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:appDelegate.defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
            return;
        }
        else if([nameTextField.text isEqualToString:@""]){
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Please enter name" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:appDelegate.defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
            return;
        }
        else{
            [spinner startAnimating];
            Wilddog *userSignUp = [[Wilddog alloc] initWithUrl:@"https://tar.wilddogio.com"];
            [userSignUp createUser:emailTextField.text password:passwordTextField.text withCompletionBlock:^(NSError * _Nullable error) {
                if (error) {
                    NSString *errorMessage = [error localizedDescription];
                    [spinner stopAnimating];
                    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error" message:errorMessage preferredStyle:UIAlertControllerStyleAlert];
                    [alert addAction:appDelegate.defaultAction];
                    [self presentViewController:alert animated:YES completion:nil];
                } else {
                    [userSignUp authUser:emailTextField.text password:passwordTextField.text withCompletionBlock:^(NSError * _Nullable error, WAuthData * _Nullable authData) {
                        if (error) {
                            NSString *errorMessage = [error localizedDescription];
                            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error" message:errorMessage preferredStyle:UIAlertControllerStyleAlert];
                            [alert addAction:appDelegate.defaultAction];
                            [self presentViewController:alert animated:YES completion:nil];
                        }
                        else{
                            appDelegate.uid = authData.uid;
                            NSDictionary *user_info = @{
                                                        @"email" : emailTextField.text,
                                                        @"id" : @"tutor",
                                                        @"name" : nameTextField.text
                                                        };
                            appDelegate.email = emailTextField.text;
                            appDelegate.name = nameTextField.text;
                            NSDictionary *new_user = @{appDelegate.uid : user_info};
                            Wilddog *userInfo = [userSignUp childByAppendingPath:@"users"];
                            [userInfo updateChildValues:new_user];
                        }
                    }];
                    [spinner stopAnimating];
                    NSLog(@"user should have signed up");
                    UIViewController* viewcontroller = [appDelegate.storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
                    [self presentViewController:viewcontroller animated:YES completion:nil];
                }
            }];
        }
    //sign up end here
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end