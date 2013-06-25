//
//  CommunicationViewController.m
//  Bokusing
//
//  Created by 竹林 英雄 on 13/05/25.
//  Copyright (c) 2013年 竹林 英雄. All rights reserved.
//

#import "CommunicationViewController.h"

@interface CommunicationViewController ()

@end

@implementation CommunicationViewController
{
    GKPeerPickerController *ppicker;
    int time;
    int count;
    NSTimer *tm;
    AVAudioPlayer *audio;
    NSString *coment;
    
}
//-------------------------------------------

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//-------------------------------------------

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Bluetooth検索
    ppicker = [[GKPeerPickerController alloc]init];
    ppicker.delegate = self;
    ppicker.connectionTypesMask = GKPeerPickerConnectionTypeNearby;
    [ppicker show];
    
    
    time = 10;
    count = 0;
    
    
    //再生フャイルの指定
    NSString *bu = [[NSBundle mainBundle]pathForResource:@"bu"ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:bu];
    audio = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    //再生設定
    audio.volume = 0.1;//ボリューム
    audio.numberOfLoops = 1;//ループ回数
    [audio prepareToPlay];//再生準備
}

//-------------------------------------------

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

//-------------------------------------------

//接続時
- (void) peerPickerController : (GKPeerPickerController *)picker
    didConnectPeer:(NSString *)peerID toSession:(GKSession *)session
{
    //セッション保持
    _Bluetooth = session;
    session.delegate = self;
    [session setDataReceiveHandler:self withContext:nil];
    
    //picker消去
    [picker dismiss];
}

//-------------------------------------------

//データ送信
- (void)sendJanken:(NSString *)str
{
    NSData * data = [str dataUsingEncoding:NSUTF8StringEncoding];
    [self.Bluetooth sendDataToAllPeers:data withDataMode:GKSendDataReliable error:nil];
}

//-------------------------------------------

//データー受信
- (void) recevieData:(NSData *)data fromPeer:(NSString *)peer
inSession:(GKSession *)session context:(void *)context
{
    NSString *str = [[NSString alloc]initWithData:data
                                  encoding:NSUTF8StringEncoding];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Data received"
                                                    message:str
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];//アラートビュー表示
    //[alert release];
}

//-------------------------------------------

//アラート処理
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:
(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        //タイマー生成
        tm = [NSTimer scheduledTimerWithTimeInterval:1
                                              target:self
                                            selector:@selector(moveLabel:)
                                            userInfo:nil
                                             repeats:YES];
    }else{
       
    }
}
//-------------------------------------------

//タイマーで行う処理
-(void)moveLabel:(NSTimer *)timer
{
    time--;
    _TimeLabel.text = [NSString stringWithFormat:@"残り%d秒",time];
    
    if (time == 0) {
        //タイマーを停止する
        [tm invalidate];
        _TimeLabel.text = @"終了";
        if (count <= 30) {
            coment = @"へたくそ!!";
        }else if(count <= 40){
            coment = @"センスないな(笑)";
        }else if(count <= 60){
            coment = @"一般人!";
        }else if(count <= 80){
            coment = @"頑張ったな!!";
        }else{
            coment = @"すごいやないかーーーい!!";
        }
        
        //アラート宣言
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:coment
                              message:@"リトライ？"
                              delegate:self
                              cancelButtonTitle:@"キャンセル"
                              otherButtonTitles:@"もう一度", nil];
        alert.tag = 1;
        //アラート表示
        [alert show];
    }
}
//-------------------------------------------

- (IBAction)GameButton:(id)sender {
    count++;
    _CountLabel.text = [NSString stringWithFormat:@"%dヒット",count];
    
    
    [audio play];
}
@end
