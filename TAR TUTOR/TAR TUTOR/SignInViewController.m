//
//  SignInViewController.m
//  TAR TUTOR
//
//  Created by Jiasheng Zhu on 4/4/16.
//  Copyright © 2016 Jiasheng Zhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SignInViewController.h"
@interface SignInViewController ()

@end

@implementation SignInViewController

@synthesize appDelegate;

UITextField *signinEmailTextField;
UITextField *signinPasswordTextField;
UIActivityIndicatorView* signinSpinner;

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
    //add email text field
    signinEmailTextField = [[UITextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.15, screenRect.size.height*0.4, screenRect.size.width*0.7, 31)];
    signinEmailTextField.borderStyle = UITextBorderStyleNone;
    signinEmailTextField.placeholder = @" Email";
    signinEmailTextField.delegate = self;
    [signinEmailTextField setKeyboardType:UIKeyboardTypeEmailAddress];
    [signinEmailTextField setAutocorrectionType:UITextAutocorrectionTypeNo];
    [self.view addSubview:signinEmailTextField];
    
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
    signinPasswordTextField = [[UITextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.15, screenRect.size.height*0.5, screenRect.size.width*0.7, 31)];
    [signinPasswordTextField setSecureTextEntry:YES];
    signinPasswordTextField.borderStyle = UITextBorderStyleNone;
    signinPasswordTextField.placeholder = @" Password";
    signinPasswordTextField.delegate = self;
    [self.view addSubview:signinPasswordTextField];
    
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
    
    //add sign in button
    UIButton *signInButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    signInButton.frame = CGRectMake(screenRect.size.width*0.2, screenRect.size.height*0.6 + 35, screenRect.size.width*0.6, 50);
    signInButton.tag = 1;
    [signInButton setTitle:@"Sign In  " forState:UIControlStateNormal];
    [signInButton.titleLabel setFont:[UIFont systemFontOfSize:20]];
    [signInButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    signInButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    signInButton.layer.borderColor = [UIColor grayColor].CGColor;
    signInButton.layer.borderWidth=1.0f;
    signInButton.layer.cornerRadius = screenRect.size.width*0.4/10.0f;
    [signInButton addTarget:self action:@selector(didTapButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:signInButton];
    
    //add sign up button
    
    UIButton *signUpButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    signUpButton.frame = CGRectMake(screenRect.size.width*0.20, screenRect.size.height*0.7 + 50, screenRect.size.width*0.6, 50);
    signUpButton.tag = 2;
    [signUpButton setTitle:@"Sign Up  " forState:UIControlStateNormal];
    [signUpButton.titleLabel setFont:[UIFont systemFontOfSize:20]];
    [signUpButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    signUpButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    signUpButton.layer.borderColor = [UIColor grayColor].CGColor;
    signUpButton.layer.borderWidth=1.0f;
    signUpButton.layer.cornerRadius = screenRect.size.width*0.4/10.0f;
    [signUpButton addTarget:self action:@selector(didTapButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:signUpButton];
    
    //self log in
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    signinEmailTextField.text = [defaults objectForKey:@"account"];
    signinPasswordTextField.text = [defaults objectForKey:@"password"];
    
    //add a spinner
    signinSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [signinSpinner setCenter:CGPointMake(screenRect.size.width/2,  screenRect.size.height*0.55 + 30)];
    [self.view addSubview:signinSpinner];
    
}

- (void)didTapButton:(UIButton *)button
{
    if(button.tag == 2){
        UIViewController* viewcontroller = [appDelegate.storyboard instantiateViewControllerWithIdentifier:@"SignUpViewController"];
        [self presentViewController:viewcontroller animated:NO completion:nil];
    }
    else if(button.tag == 1){
        //sign in
        [self signin];
        //sign in ends here
    }
}

- (void)signin
{
    [signinSpinner startAnimating];
    [[FIRAuth auth] signInWithEmail:signinEmailTextField.text password:signinPasswordTextField.text completion:^(FIRUser *_Nullable user,NSError *error) {
        if (error) {
            [signinSpinner stopAnimating];
            NSString *errorMessage = [error localizedDescription];
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error" message:errorMessage preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:appDelegate.defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
            
        } else {
            appDelegate.uid = user.uid;
            NSString *account = [signinEmailTextField text];
            NSString *password  = [signinPasswordTextField text];
            NSString *signOut  = @"False";
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:account forKey:@"account"];
            [defaults setObject:password forKey:@"password"];
            [defaults synchronize];
            FIRDatabaseReference* checkIfIsTutor = [[FIRDatabase database] reference];
            checkIfIsTutor = [checkIfIsTutor child:@"users"];
            [checkIfIsTutor observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot *snapshot) {
                NSDictionary *allUsers = snapshot.value;
                [signinSpinner stopAnimating];
                if([allUsers objectForKey:user.uid]!=nil){
                    allUsers = allUsers[user.uid];
                    if([allUsers[@"id"] isEqualToString:@"tutor"]){
                        UIViewController* viewcontroller = [appDelegate.storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
                        [self presentViewController:viewcontroller animated:YES completion:nil];
                        [defaults setObject:signOut forKey:@"signOut"];
                        [defaults setObject:allUsers[@"name"] forKey:@"name"];
                        appDelegate.name = allUsers[@"name"];
                    }
                    else{
                        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Sorry, your identity can not be verified" preferredStyle:UIAlertControllerStyleAlert];
                        [alert addAction:appDelegate.defaultAction];
                        [self presentViewController:alert animated:YES completion:nil];
                    }
                }
            }];
        }
    }];
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
