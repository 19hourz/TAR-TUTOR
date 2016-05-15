//
//  ResultsViewController.m
//  TAR TUTOR
//
//  Created by Jiasheng Zhu on 4/20/16.
//  Copyright © 2016 Jiasheng Zhu. All rights reserved.
//

//#import <Foundation/Foundation.h>
//#import "ResultsViewController.h"
//#define blockHeight screenRect.size.width*0.4
//@interface ResultsViewController()
//
//@end
//
//@implementation ResultsViewController
//
//@synthesize appDelegate;
//
//Firebase* loadAllClasses;
//NSDictionary* allClasses;
//UIScrollView *scrollView;
//CGFloat scrollViewContentHeight;
//CGRect screenRect;
//UIActivityIndicatorView* resultsSpinner;
//
//
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    //general initialization
//    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    screenRect = [[UIScreen mainScreen] bounds];
//    scrollViewContentHeight = screenRect.size.width*0.1;
//    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, screenRect.size.height*0.15, self.view.frame.size.width, screenRect.size.height*0.85)];
//    [scrollView setContentSize:CGSizeMake(scrollView.bounds.size.width, scrollViewContentHeight)];
//    [self.view addSubview:scrollView];
//    //add a black block at the top
//    UIView *blackTop  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height*0.15)];
//    blackTop.backgroundColor = [UIColor blackColor];
//    [self.view addSubview:blackTop];
//
//    //add a spinner
//    resultsSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    resultsSpinner.color = [UIColor magentaColor];
//    [resultsSpinner setCenter:CGPointMake(screenRect.size.width/2,  screenRect.size.height/2)];
//    [self.view addSubview:resultsSpinner];
//    [resultsSpinner startAnimating];
//    //data connection
//    loadAllClasses = [[Firebase alloc] initWithUrl:@"https://taruibe.firebaseio.com"];
//    loadAllClasses = [loadAllClasses childByAppendingPath:@"classes"];
//    allClasses = [[NSDictionary alloc] init];
//    [loadAllClasses observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
//        allClasses = snapshot.value;
//        if (allClasses == nil || ![allClasses isKindOfClass:[NSDictionary class]]) {
//            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"There is no class found" preferredStyle:UIAlertControllerStyleAlert];
//            [alert addAction:appDelegate.defaultAction];
//            [self presentViewController:alert animated:YES completion:nil];
//        }
//        else{
//            [self showResults];
//        }
//    }];
//}
//
//- (UIStatusBarStyle)preferredStatusBarStyle
//{
//    return UIStatusBarStyleLightContent;
//}
//
//- (void)showResults
//{
//    NSArray* allDates = allClasses.allKeys;
//    for(int i = 0; i < allDates.count; ++i){
//        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//        button.tag = 1;
//        NSString* info = @" ";
//        //info = [info stringByAppendingString:@"   "];
//        info = [info stringByAppendingString:allDates[i]];
//        info = [info stringByAppendingString:@"\n"];
//        info = [info stringByAppendingString:@"Instructor:"];
//        info = [info stringByAppendingString:@"Name"];
//        info = [info stringByAppendingString:@"\n"];
//        info = [info stringByAppendingString:@"Number of students signed in:"];
//        info = [info stringByAppendingString:@"##"];
//        [button addTarget:self action:@selector(didTapButton:) forControlEvents:UIControlEventTouchUpInside];
//        button.frame = CGRectMake(screenRect.size.width*0.06, scrollViewContentHeight, screenRect.size.width*0.88, blockHeight);
//        button.clipsToBounds = YES;
//        button.layer.cornerRadius = screenRect.size.width*0.4/32.0f;
//        button.layer.borderColor=[UIColor grayColor].CGColor;
//        button.layer.borderWidth=2.0f;
//        [scrollView addSubview:button];
//        UILabel *buttonInfo = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.1, scrollViewContentHeight, screenRect.size.width*0.8, blockHeight)];
//        buttonInfo.text = info;
//        [buttonInfo setFont:[UIFont fontWithName:@"Courier" size:blockHeight/7]];
//        [buttonInfo setTextColor:[UIColor blackColor]];
//        [buttonInfo setTextAlignment:NSTextAlignmentNatural];
//        [buttonInfo setNumberOfLines:7];
//        [scrollView addSubview:buttonInfo];
//        scrollViewContentHeight += screenRect.size.width*0.5;
//        [scrollView setContentSize:CGSizeMake(scrollView.bounds.size.width, scrollViewContentHeight)];
//    }
//    [resultsSpinner stopAnimating];
//}
//
//- (void)didTapButton: (UIButton *) button
//{
//    
//}
//
//@end