//
//  BluetoothViewController.m
//  Bokusing
//
//  Created by 竹林 英雄 on 13/05/25.
//  Copyright (c) 2013年 竹林 英雄. All rights reserved.
//

#import "BluetoothViewController.h"

@interface BluetoothViewController ()

@end

@implementation BluetoothViewController

//------------------------------------

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//------------------------------------

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Bluetooth検索
    GKPeerPickerController *ppicker;
    ppicker = [[GKPeerPickerController alloc]init];
    ppicker.delegate = self;
    ppicker.connectionTypesMask = GKPeerPickerConnectionTypeNearby;
    [ppicker show];
}

//------------------------------------

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

//------------------------------------

@end
