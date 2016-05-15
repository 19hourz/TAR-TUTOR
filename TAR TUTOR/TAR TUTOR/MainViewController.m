//
//  MainViewController.m
//  TAR TUTOR
//
//  Created by Jiasheng Zhu on 4/5/16.
//  Copyright © 2016 Jiasheng Zhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainViewController.h"
#import <QuartzCore/QuartzCore.h>
#define blockHeight screenRect.size.width*0.4
#define allOtherButtons 6
#define leftView 0
#define rightView 1
@interface MainViewController()

@end

@implementation MainViewController

@synthesize appDelegate;

UIActivityIndicatorView* mainSpinner;
Firebase* loadAllClasses;
NSDictionary* allClasses;
UIScrollView *rightScrollView;
CGFloat scrollViewContentHeight;
NSUInteger presentedViewController;
UIView* leftButtonView;
UIView* littleCircle;
NSMutableDictionary* mapping;
UIView* detailView;
NSDictionary *currentClass;

- (void)viewDidLoad {
    //general initialization
    [super viewDidLoad];
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    presentedViewController = leftView;
    //add left button view
    leftButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, screenRect.size.height*0.13, screenRect.size.width, screenRect.size.height*0.87)];
    [self.view addSubview:leftButtonView];
    //add scroll view
    scrollViewContentHeight = screenRect.size.width*0.1;
    rightScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, screenRect.size.height*0.13, screenRect.size.width,  screenRect.size.height*0.87)];
    [rightScrollView setContentSize:CGSizeMake(rightScrollView.bounds.size.width, scrollViewContentHeight)];
    //create a round button to create class
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = 1;
    [button setTitle:@"Begin Class" forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:20]];
    [button setTitleColor:[UIColor colorWithRed:26/255.0 green:102/255.0 blue:140/255.0 alpha:1] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(didTapButton:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(screenRect.size.width*0.3, screenRect.size.height*0.12, screenRect.size.width*0.4, screenRect.size.width*0.4);
    button.clipsToBounds = YES;
    button.layer.cornerRadius = screenRect.size.width*0.4/2.0f;
    button.layer.borderColor=[UIColor redColor].CGColor;
    button.layer.borderWidth=2.0f;
    [leftButtonView addSubview:button];
    //create a round button
    UIButton *resumeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    resumeButton.tag = 2;
    [resumeButton setTitle:@"Resume Class" forState:UIControlStateNormal];
    [resumeButton.titleLabel setFont:[UIFont systemFontOfSize:20]];
    [resumeButton setTitleColor:[UIColor colorWithRed:26/255.0 green:102/255.0 blue:140/255.0 alpha:1] forState:UIControlStateNormal];
    [resumeButton addTarget:self action:@selector(didTapButton:) forControlEvents:UIControlEventTouchUpInside];
    resumeButton.frame = CGRectMake(screenRect.size.width*0.3, screenRect.size.height*0.52, screenRect.size.width*0.4, screenRect.size.width*0.4);
    resumeButton.clipsToBounds = YES;
    resumeButton.layer.cornerRadius = screenRect.size.width*0.4/2.0f;
    resumeButton.layer.borderColor=[UIColor redColor].CGColor;
    resumeButton.layer.borderWidth=2.0f;
    [leftButtonView addSubview:resumeButton];
    //add a spinner
    mainSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [mainSpinner setCenter:CGPointMake(screenRect.size.width/2,  screenRect.size.height*0.55)];
    [self.view addSubview:mainSpinner];
    [mainSpinner startAnimating];

    //add a black block at the top
    UIView *blackTop  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height*0.13)];
    blackTop.backgroundColor = [UIColor blackColor];
    [self.view addSubview:blackTop];
    //add a white circle at the top
    littleCircle = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.25, screenRect.size.height*0.115, screenRect.size.width*0.05, screenRect.size.width*0.05)];
    littleCircle.alpha = 1;
    littleCircle.layer.cornerRadius = screenRect.size.width*0.5*0.05;
    littleCircle.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:littleCircle];
    //add two navigation button
    UIButton* left = [UIButton buttonWithType:UIButtonTypeCustom];
    left.tag = 3;
    [left setTitle:@"Classes" forState:UIControlStateNormal];
    [left setFrame:CGRectMake(0, screenRect.size.height*0.07, screenRect.size.width*0.5, screenRect.size.height*0.05)];
    [left setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [left addTarget:self action:@selector(didTapButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:left];
    UIButton* right = [UIButton buttonWithType:UIButtonTypeCustom];
    right.tag = 4;
    [right setTitle:@"Results" forState:UIControlStateNormal];
    [right setFrame:CGRectMake(screenRect.size.width*0.5, screenRect.size.height*0.07, screenRect.size.width*0.5, screenRect.size.height*0.05)];
    [right setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [right addTarget:self action:@selector(didTapButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:right];
    //data connection
    loadAllClasses = [[Firebase alloc] initWithUrl:@"https://taruibe.firebaseio.com"];
    loadAllClasses = [loadAllClasses childByAppendingPath:@"classes"];
    allClasses = [[NSDictionary alloc] init];
    [loadAllClasses observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        allClasses = snapshot.value;
        if (allClasses == nil || ![allClasses isKindOfClass:[NSDictionary class]]) {
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"There is no class found" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:appDelegate.defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
        else{
            [self showResults];
        }
    }];
    detailView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.1, screenRect.size.height*0.07, screenRect.size.width*0.8, screenRect.size.height*0.86)];
    detailView.alpha = 1;
    detailView.backgroundColor = [UIColor whiteColor];
    detailView.layer.masksToBounds = NO;
    //trial.layer.shadowOffset = CGSizeMake(1, 1);
    detailView.layer.shadowRadius = screenRect.size.width/32.0;
    detailView.layer.shadowOpacity = 0.3;
}

- (void)viewDidAppear:(BOOL)animated
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    appDelegate.name = [defaults objectForKey:@"name"];
    [appDelegate.firebase authUser:[defaults objectForKey:@"account"] password:[defaults objectForKey:@"password"] withCompletionBlock:^(NSError *error, FAuthData *authData) {
        if (error) {
            if([mainSpinner isAnimating]){
                [mainSpinner stopAnimating];
            }
            UIAlertAction* alertaction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                UIViewController* viewcontroller = [appDelegate.storyboard instantiateViewControllerWithIdentifier:@"SignInViewController"];
                [self presentViewController:viewcontroller animated:YES completion:nil];
            }];
            NSString *errorMessage = [error localizedDescription];
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error" message:errorMessage preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:alertaction];
            [self presentViewController:alert animated:YES completion:nil];
            
        } else {
            Firebase* checkIfIsTutor = [[Firebase alloc] initWithUrl:@"https://taruibe.firebaseio.com"];
            checkIfIsTutor = [checkIfIsTutor childByAppendingPath:@"users"];
            [checkIfIsTutor observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
                NSDictionary *allUsers = snapshot.value;
                if([mainSpinner isAnimating]){
                    [mainSpinner stopAnimating];
                }
                if([allUsers objectForKey:authData.uid]!=nil){
                    allUsers = allUsers[authData.uid];
                    if([allUsers[@"id"] isEqualToString:@"tutor"]){
                        [defaults setObject:@"False" forKey:@"signOut"];
                        [defaults setObject:allUsers[@"name"] forKey:@"name"];
                        appDelegate.name = allUsers[@"name"];
                    }
                    else{
                        UIAlertAction* alertaction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                            UIViewController* viewcontroller = [appDelegate.storyboard instantiateViewControllerWithIdentifier:@"SignInViewController"];
                            [self presentViewController:viewcontroller animated:YES completion:nil];
                        }];
                        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Sorry, your identity can not be verified" preferredStyle:UIAlertControllerStyleAlert];
                        [alert addAction:alertaction];
                        [self presentViewController:alert animated:YES completion:nil];
                    }
                }
            }];
            appDelegate.uid = authData.uid;
        }
    }];
    
}

- (void)didTapButton:(UIButton *)button{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    if(button.tag == 0 && [[self.view subviews] containsObject:detailView]){
        for(unsigned long i = (detailView.subviews.count - 1); i > -1; --i){
            [detailView.subviews[i] removeFromSuperview];
        }
        [detailView removeFromSuperview];
        return;
    }
    else if (([mainSpinner isAnimating] || [[self.view subviews] containsObject:detailView])&&button.tag!=5) {
        return;
    }
    else if(button.tag == 1){
        [mainSpinner startAnimating];
        Firebase *oberser = appDelegate.firebase;
        [oberser childByAppendingPath:@"classes"];
        [oberser observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
            NSDateFormatter *dateformate=[[NSDateFormatter alloc]init];
            [dateformate setDateFormat:@"dd-MM-YYYY"];
            NSString *date_String=[dateformate stringFromDate:[NSDate date]];
            NSMutableDictionary *allDates = snapshot.value[@"classes"];
            if(allDates.count==0){//changed
                NSLog(@"no class yet");
                double CurrentTime = CACurrentMediaTime();
                CurrentTime = CurrentTime * 1000000;
                NSUInteger timeInt = (NSUInteger)CurrentTime;
                timeInt = timeInt%10000;
                NSUInteger random = rand()%10;
                NSUInteger uid = random  + timeInt*10;
                uid = uid % 100000;
                while(uid < 10000){
                    uid = uid*10 + rand()%10;
                }
                NSString *classuid = [NSString stringWithFormat:@"%lu", (unsigned long)uid];
                NSDictionary *classinfo = @{@"code" : classuid,
                                           @"instructor" : oberser.authData.uid};
                NSDictionary *newClass = @{classuid : classinfo};
                NSDictionary *newClasses = @{date_String : newClass};
                NSDictionary *classes = @{@"classes" : newClasses};
                [oberser updateChildValues:classes];
                appDelegate.currentClassCode = classuid;
                if([mainSpinner isAnimating]){
                    [mainSpinner stopAnimating];
                }
                UIViewController* viewcontroller = [appDelegate.storyboard instantiateViewControllerWithIdentifier:@"CurrentClassViewController"];
                [self presentViewController:viewcontroller animated:YES completion:nil];
            }
            else{
                NSMutableDictionary *allClasses = allDates[date_String];
                double CurrentTime = CACurrentMediaTime();
                CurrentTime = CurrentTime * 1000000;
                NSUInteger timeInt = (NSUInteger)CurrentTime;
                timeInt = timeInt%10000;
                NSUInteger random = rand()%10;
                NSUInteger uid = random  + timeInt*10;
                uid = uid % 100000;
                while(uid < 10000){
                    uid = uid*10 + rand()%10;
                }
                NSString *classuid = [NSString stringWithFormat:@"%lu", (unsigned long)uid];
                NSLog(@"%@ and %@", classuid, appDelegate.name);
                NSDictionary *classinfo = @{@"code" : classuid,
                                            @"instructor" : appDelegate.name};
                if(allClasses != nil)
                    [allClasses setObject:classinfo forKey:classuid];
                else
                    allClasses = (NSMutableDictionary *)@{classuid : classinfo};
                [allDates setObject:allClasses forKey:date_String];
                NSDictionary *classes = @{@"classes" : allDates};
                [oberser updateChildValues:classes];
                appDelegate.currentClassCode = classuid;
                if([mainSpinner isAnimating]){
                    [mainSpinner stopAnimating];
                }
                UIViewController* viewcontroller = [appDelegate.storyboard instantiateViewControllerWithIdentifier:@"CurrentClassViewController"];
                [self presentViewController:viewcontroller animated:YES completion:nil];
            }
        }];
    }
    else if(button.tag == 2){
        [mainSpinner startAnimating];
        Firebase *oberser = appDelegate.firebase;
        [oberser childByAppendingPath:@"classes"];
        [oberser observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
            NSDateFormatter *dateformate=[[NSDateFormatter alloc]init];
            [dateformate setDateFormat:@"dd-MM-YYYY"];
            NSString *date_String=[dateformate stringFromDate:[NSDate date]];
            NSMutableDictionary *allDates = snapshot.value[@"classes"];
            if(allDates.count==0){//changed
                NSLog(@"no class yet");
                if([mainSpinner isAnimating]){
                    [mainSpinner stopAnimating];
                }
                UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"There is no class found" preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:appDelegate.defaultAction];
                [self presentViewController:alert animated:YES completion:nil];
            }
            else{
                NSMutableDictionary *allClasses = allDates[date_String];
                NSArray<NSString *> *allcodes = allClasses.allKeys;
                NSString *classuid = [[NSString alloc] init];
                for(int i = 0; i < allcodes.count; ++i){
                    if([allClasses[allcodes[i]][@"instructor"] isEqualToString:appDelegate.name]){
                        classuid = allcodes[i];
                    }
                }
                if([mainSpinner isAnimating]){
                    [mainSpinner stopAnimating];
                }
                if(![classuid isEqualToString:@""]){
                    appDelegate.currentClassCode = classuid;
                    UIViewController* viewcontroller = [appDelegate.storyboard instantiateViewControllerWithIdentifier:@"CurrentClassViewController"];
                    [self presentViewController:viewcontroller animated:YES completion:nil];
                }
                else{
                    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"There is no class found" preferredStyle:UIAlertControllerStyleAlert];
                    [alert addAction:appDelegate.defaultAction];
                    [self presentViewController:alert animated:YES completion:nil];
                }
            }
        }];
    }
    else if(button.tag == 3){
        if(presentedViewController == leftView){
            //do nothing
        }
        else{
            presentedViewController = leftView;
            [littleCircle setFrame:CGRectMake(screenRect.size.width*0.25, screenRect.size.height*0.115, screenRect.size.width*0.05, screenRect.size.width*0.05)];
            [rightScrollView removeFromSuperview];
            [self.view addSubview:leftButtonView];
        }
    }
    else if(button.tag == 4){
        if(presentedViewController == rightView){
            //do nothing
        }
        else{
            [littleCircle setFrame:CGRectMake(screenRect.size.width*0.75, screenRect.size.height*0.115, screenRect.size.width*0.05, screenRect.size.width*0.05)];
            presentedViewController = rightView;
            [leftButtonView removeFromSuperview];
            [self.view addSubview:rightScrollView];
        }
    }
    else if(button.tag == 5){
        [UIPasteboard generalPasteboard].string = [NSString stringWithFormat:@"%@", currentClass];
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Copied!" message:@"Please open another app and you could paste the details of this class to it" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:appDelegate.defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else{
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        backButton.frame = CGRectMake(detailView.frame.size.width*0.10, detailView.frame.size.height*0.8725, detailView.frame.size.width*0.8, detailView.frame.size.height*0.1);
        backButton.tag = 0;
        [backButton setBackgroundColor:[UIColor redColor]];
        [backButton setTitle:@"Close" forState:UIControlStateNormal];
        [backButton.titleLabel setFont:[UIFont systemFontOfSize:20]];
        [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        backButton.layer.borderColor = [UIColor clearColor].CGColor;
        backButton.layer.borderWidth=1.0f;
        backButton.layer.cornerRadius = screenRect.size.width*0.4/10.0f;
        [backButton addTarget:self action:@selector(didTapButton:) forControlEvents:UIControlEventTouchUpInside];
        [detailView addSubview:backButton];
        UIButton *copyButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        copyButton.frame = CGRectMake(detailView.frame.size.width*0.10, detailView.frame.size.height*0.75, detailView.frame.size.width*0.8, detailView.frame.size.height*0.1);
        copyButton.tag = 5;
        [copyButton setBackgroundColor:[UIColor lightGrayColor]];
        [copyButton setTitle:@"Copy" forState:UIControlStateNormal];
        [copyButton.titleLabel setFont:[UIFont systemFontOfSize:20]];
        [copyButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        copyButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        copyButton.layer.borderColor = [UIColor clearColor].CGColor;
        copyButton.layer.borderWidth=1.0f;
        copyButton.layer.cornerRadius = screenRect.size.width*0.4/10.0f;
        [copyButton addTarget:self action:@selector(didTapButton:) forControlEvents:UIControlEventTouchUpInside];
        [detailView addSubview:copyButton];
        NSUInteger index = button.tag - allOtherButtons;
        NSArray* allDates = allClasses.allKeys;
        NSDictionary *temp = [mapping objectForKey:[NSString stringWithFormat:@"%lu", index ]];
        NSUInteger i = (NSUInteger)[temp.allKeys[0] integerValue];
        NSUInteger j = (NSUInteger)[[temp objectForKey:temp.allKeys[0]] integerValue];
        NSDictionary* oneDay = allClasses[allDates[i]];
        currentClass = oneDay[oneDay.allKeys[j]];
        NSLog(@"Date: %@", allDates[i]);
        NSLog(@"Code: %@", oneDay.allKeys[j]);
        NSLog(@"Instructor: %@", currentClass[@"instructor"]);
        NSUInteger numOfStudents = 0;
        CGFloat averageBatteryUse = 0.0;
        CGFloat averageInClassTime = 0.0;
        if(currentClass[@"students"] == nil){
            NSLog(@"Num of Students: %lu", numOfStudents);
        }
        else{
            NSDictionary* students = currentClass[@"students"];
            numOfStudents = students.allKeys.count;
            NSLog(@"Num of Students: %lu", numOfStudents);
            CGFloat totalInClassTime = 0.0;
            NSUInteger validNum = 0;
            CGFloat totalBatteryUse = 0.0;
            NSString* startTime = @"";
            NSString* endTime = @"";
            NSInteger startH = 0, startM = 0, startS = 0, endH = 0, endM = 0, endS = 0;
            for(int k = 0; k < numOfStudents; ++k){
                NSDictionary* student = students[students.allKeys[k]];
                if(student[@"endbattery"] == nil || student[@"endtime"] == nil){
                    
                }
                else{
                    validNum++;
                    totalBatteryUse += [student[@"endbattery"] floatValue] - [student[@"startbattery"] floatValue];
                    startTime = student[@"starttime"];
                    endTime = student[@"endtime"];
                    startH = [[[startTime substringFromIndex:6] substringToIndex:2] integerValue];
                    startM = [[[startTime substringFromIndex:9] substringToIndex:2] integerValue];
                    startS = [[[startTime substringFromIndex:12] substringToIndex:2] integerValue];
                    endH = [[[endTime substringFromIndex:6] substringToIndex:2] integerValue];
                    endM = [[[endTime substringFromIndex:9] substringToIndex:2] integerValue];
                    endS = [[[endTime substringFromIndex:12] substringToIndex:2] integerValue];
                    totalInClassTime += (CGFloat)((endS - startS) + (endM - startM)*60 + (endH - startH)*3600);
                    NSLog(@"%@: %ld %ld %ld %@: %ld %ld %ld total: %ld",startTime, (long)startH, (long)startM, (long)startS,endTime, (long)endH, (long)endM, (long)
                          endS, (long)totalInClassTime);
                }
            }
            averageBatteryUse = totalBatteryUse/validNum;
            averageInClassTime = totalInClassTime/validNum;
            averageBatteryUse = averageBatteryUse*100; //In percetage
            averageInClassTime = averageInClassTime/60; //In minutes
            NSLog(@"%f, %f", averageInClassTime, averageBatteryUse);
        }
        NSArray<NSString *>* infos = [[NSArray alloc] initWithObjects:@"Date: ", @"Code: ", @"Instructor: ", @"Num of students: ", @"Average use of battery", @"Average time in class: ", nil];
        NSArray<NSString *>* datas = [[NSArray alloc] initWithObjects:allDates[i],oneDay.allKeys[j], currentClass[@"instructor"], [NSString stringWithFormat:@"%lu", numOfStudents], [[NSString stringWithFormat:@"%0.1f", averageBatteryUse] stringByAppendingString:@" \%"],[[NSString stringWithFormat:@"%0.1f", averageInClassTime] stringByAppendingString:@" minutes"], nil];
        CGFloat x = detailView.frame.size.width * 0.1, y = detailView.frame.size.height * 0.01;
        NSUInteger cells = 4;
        for(NSUInteger cell = 0; cell < cells; ++cell){
            UILabel* info = [[UILabel alloc] initWithFrame:CGRectMake(x, y, detailView.frame.size.width*0.8, detailView.frame.size.height*0.08)];
            info.text = infos[cell];
            [info setTextAlignment:NSTextAlignmentLeft];
            [detailView addSubview:info];
            UILabel* data = [[UILabel alloc] initWithFrame:CGRectMake(x, y, detailView.frame.size.width*0.8, detailView.frame.size.height*0.08)];
            data.text = datas[cell];
            [data setTextAlignment:NSTextAlignmentRight];
            [detailView addSubview:data];
            UIBezierPath *path = [UIBezierPath bezierPath];
            [path moveToPoint:CGPointMake(detailView.frame.size.width * 0.05, y + detailView.frame.size.height*0.08)];
            [path addLineToPoint:CGPointMake(detailView.frame.size.width*0.95, y + detailView.frame.size.height*0.08)];
            CAShapeLayer *shapeLayer = [CAShapeLayer layer];
            shapeLayer.path = [path CGPath];
            shapeLayer.strokeColor = [UIColor grayColor].CGColor;
            shapeLayer.lineWidth = 1.0;
            shapeLayer.fillColor = [[UIColor clearColor] CGColor];
            [detailView.layer addSublayer:shapeLayer];
            y += detailView.frame.size.height * 0.09;
        }
        if (numOfStudents != 0) {
            for(NSUInteger cell = cells; cell < infos.count; ++cell){
                UILabel* info = [[UILabel alloc] initWithFrame:CGRectMake(x, y, detailView.frame.size.width*0.8, detailView.frame.size.height*0.08)];
                info.text = infos[cell];
                [info setTextAlignment:NSTextAlignmentLeft];
                [detailView addSubview:info];
                y += detailView.frame.size.height * 0.08;
                UILabel* data = [[UILabel alloc] initWithFrame:CGRectMake(x, y, detailView.frame.size.width*0.8, detailView.frame.size.height*0.08)];
                data.text = datas[cell];
                [data setTextAlignment:NSTextAlignmentRight];
                [detailView addSubview:data];
                UIBezierPath *path = [UIBezierPath bezierPath];
                [path moveToPoint:CGPointMake(detailView.frame.size.width * 0.05, y + detailView.frame.size.height*0.08)];
                [path addLineToPoint:CGPointMake(detailView.frame.size.width*0.95, y + detailView.frame.size.height*0.08)];
                CAShapeLayer *shapeLayer = [CAShapeLayer layer];
                shapeLayer.path = [path CGPath];
                shapeLayer.strokeColor = [UIColor grayColor].CGColor;
                shapeLayer.lineWidth = 1.0;
                shapeLayer.fillColor = [[UIColor clearColor] CGColor];
                [detailView.layer addSublayer:shapeLayer];
                y += detailView.frame.size.height * 0.09;
            }
        }
        [self.view addSubview:detailView];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)showResults
{
    mapping = [[NSMutableDictionary alloc] init];
    NSUInteger generalCounter = 0;
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    NSArray* allDates = allClasses.allKeys;
    for(NSUInteger i = 0; i < allDates.count; ++i){
        NSDictionary* oneDay = allClasses[allDates[i]];
        NSArray* classesCodeInOneDay = oneDay.allKeys;
        for(NSUInteger j = 0; j < classesCodeInOneDay.count; ++j){
            unsigned short num = 0;
            if(oneDay[classesCodeInOneDay[j]][@"students"] != 0){
                num = ((NSDictionary *)oneDay[classesCodeInOneDay[j]][@"students"]).allKeys.count;
            }
            NSString* numOfStudents = [NSString stringWithFormat:@"%hu", num];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            generalCounter++;
            NSDictionary *temp = @{[NSString stringWithFormat:@"%lu", i]:[NSString stringWithFormat:@"%lu", j]};
            [mapping setObject:temp forKey:[NSString stringWithFormat:@"%lu", generalCounter]];
            button.tag = allOtherButtons+generalCounter;
            NSString* info = @"";
            info = [info stringByAppendingString:allDates[i]];
            info = [info stringByAppendingString:@"\n"];
            info = [info stringByAppendingString:@"Instructor:"];
            info = [info stringByAppendingString:oneDay[classesCodeInOneDay[j]][@"instructor"]];
            info = [info stringByAppendingString:@"\n"];
            info = [info stringByAppendingString:@"Number of students signed in: "];
            info = [info stringByAppendingString:numOfStudents];
            [button addTarget:self action:@selector(didTapButton:) forControlEvents:UIControlEventTouchUpInside];
            button.frame = CGRectMake(screenRect.size.width*0.06, scrollViewContentHeight, screenRect.size.width*0.88, blockHeight);
            button.clipsToBounds = YES;
            button.layer.cornerRadius = screenRect.size.width*0.4/32.0f;
            button.layer.borderColor=[UIColor grayColor].CGColor;
            button.layer.borderWidth=2.0f;
            [rightScrollView addSubview:button];
            UILabel *buttonInfo = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.1, scrollViewContentHeight, screenRect.size.width*0.8, blockHeight)];
            buttonInfo.text = info;
            [buttonInfo setFont:[UIFont fontWithName:@"Courier" size:blockHeight/7]];
            [buttonInfo setTextColor:[UIColor blackColor]];
            [buttonInfo setTextAlignment:NSTextAlignmentNatural];
            [buttonInfo setNumberOfLines:7];
            [rightScrollView addSubview:buttonInfo];
            scrollViewContentHeight += screenRect.size.width*0.5;
            [rightScrollView setContentSize:CGSizeMake(rightScrollView.bounds.size.width, scrollViewContentHeight)];
        }
    }
    if([mainSpinner isAnimating]){
        [mainSpinner stopAnimating];
    }
}


@end