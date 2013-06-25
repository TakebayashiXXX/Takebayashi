//
//  CommunicationViewController.h
//  Bokusing
//
//  Created by 竹林 英雄 on 13/05/25.
//  Copyright (c) 2013年 竹林 英雄. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>
#import <AVFoundation/AVFoundation.h>

@interface CommunicationViewController : UIViewController
<GKMatchmakerViewControllerDelegate,GKSessionDelegate>

@property (nonatomic,retain) GKSession *Bluetooth;
@property (nonatomic,retain) NSString *you;
@property (nonatomic,retain) NSString *me;
@property (weak, nonatomic) IBOutlet UILabel *TimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *CountLabel;
- (IBAction)GameButton:(id)sender;

@end
