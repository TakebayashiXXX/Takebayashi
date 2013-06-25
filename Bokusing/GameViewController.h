//
//  GameViewController.h
//  Bokusing
//
//  Created by 竹林 英雄 on 13/05/03.
//  Copyright (c) 2013年 竹林 英雄. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface GameViewController : UIViewController

- (IBAction)GameButton:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *TaimLavel;
@property (weak, nonatomic) IBOutlet UILabel *CountLavel;

@end
