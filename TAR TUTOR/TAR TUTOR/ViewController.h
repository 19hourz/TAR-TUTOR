//
//  ViewController.h
//  TAR TUTOR
//
//  Created by Jiasheng Zhu on 2/25/16.
//  Copyright © 2016 Jiasheng Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QRCodeReaderDelegate.h"

@interface ViewController : UIViewController <QRCodeReaderDelegate>

- (IBAction)scanAction:(id)sender;

@end

