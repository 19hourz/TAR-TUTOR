//
//  CurrentClassViewController.m
//  TAR TUTOR
//
//  Created by Jiasheng Zhu on 4/5/16.
//  Copyright © 2016 Jiasheng Zhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CurrentClassViewController.h"
@interface CurrentClassViewController()

@end

@implementation CurrentClassViewController

@synthesize appDelegate;

- (void)viewDidLoad {
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    [super viewDidLoad];
    //add back button
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    backButton.frame = CGRectMake(screenRect.size.width*0.20, screenRect.size.height*0.8725, screenRect.size.width*0.6, screenRect.size.height*0.1);
    backButton.tag = 1;
    [backButton setBackgroundColor:[UIColor redColor]];
    [backButton setTitle:@"Leave This Class" forState:UIControlStateNormal];
    [backButton.titleLabel setFont:[UIFont systemFontOfSize:20]];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    backButton.layer.borderColor = [UIColor clearColor].CGColor;
    backButton.layer.borderWidth=1.0f;
    backButton.layer.cornerRadius = screenRect.size.width*0.4/10.0f;
    [backButton addTarget:self action:@selector(didTapButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
}

- (void)viewDidAppear:(BOOL)animated{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    __block NSUInteger currentNum = 0;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*0.02, screenRect.size.height*0.05, screenRect.size.width*0.9, screenRect.size.height*0.07)];
    label.text = @"Access code: ";
    label.text = [label.text stringByAppendingString:appDelegate.currentClassCode];
    [label setTextAlignment:NSTextAlignmentLeft];
    label.font = [UIFont systemFontOfSize:screenRect.size.height*0.04];
    [self.view addSubview:label];
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, screenRect.size.height*0.15, self.view.frame.size.width, screenRect.size.height*0.7)];
    [scrollView setContentSize:CGSizeMake(scrollView.bounds.size.width, scrollView.bounds.size.height*3)];
    [self.view addSubview:scrollView];
    NSDateFormatter *dateformate=[[NSDateFormatter alloc]init];
    [dateformate setDateFormat:@"dd-MM-YYYY"];
    NSString *date_String=[dateformate stringFromDate:[NSDate date]];
    WDGSyncReference *currClass = [[WDGSync sync] reference];
    currClass = [currClass child:@"classes"];
    currClass = [currClass child:date_String];
    currClass = [currClass child:appDelegate.currentClassCode];
    currClass = [currClass child:@"students"];
    [currClass observeEventType:WDGDataEventTypeChildAdded withBlock:^(WDGDataSnapshot *snapshot) {
        NSLog(@"activated");
        NSDictionary *newStudent = snapshot.value;
        CGRect contentRect = CGRectZero;
        NSString *string = newStudent[@"name"];
        if(string != nil){
            UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            button.frame = CGRectMake(0, self.view.frame.size.height*0.1 * (CGFloat)currentNum++, self.view.frame.size.width,self.view.frame.size.height*0.1);//
            [button setBackgroundColor:[UIColor colorWithRed:229.0/255.0 green:247.0/255.0 blue:248.0/255.0 alpha:1]];
            button.tag = currentNum;//
            NSLog(@"new student is: %@", newStudent);
            [button setTitle:[NSString stringWithFormat:string, ((long)index + 1)] forState:UIControlStateNormal];
            [button.titleLabel setFont:[UIFont systemFontOfSize:20]];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [[button layer] setBorderWidth:2.0f];
            button.layer.borderColor = [[UIColor colorWithRed:219.0/255.0 green:237.0/255.0 blue:238.0/255.0 alpha:1] CGColor];
            button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            button.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
            [scrollView addSubview:button];
            contentRect = CGRectUnion(contentRect, button.frame);
            scrollView.contentSize = contentRect.size;
        }
    }];
}

- (void)didTapButton:(UIButton *)button
{
    if (button.tag == 1) {
        UIViewController* viewcontroller = [appDelegate.storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
        [self presentViewController:viewcontroller animated:YES completion:nil];
    }
}

@end
