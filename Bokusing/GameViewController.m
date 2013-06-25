//
//  GameViewController.m
//  Bokusing
//
//  Created by 竹林 英雄 on 13/05/03.
//  Copyright (c) 2013年 竹林 英雄. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController ()
@end

@implementation GameViewController
{
    int time;
    int count;
    NSTimer *tm;
    AVAudioPlayer *audio;
    NSString *coment;
}

//------------------------------------------

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//------------------------------------------

- (void)viewDidLoad
{
    [super viewDidLoad];
    time = 10;
    count = 0;

    //タイマー生成
    tm = [NSTimer scheduledTimerWithTimeInterval:1
                                           target:self
                                         selector:@selector(moveLabel:)
                                         userInfo:nil
                                          repeats:YES];
    
    //再生フャイルの指定
    NSString *bu = [[NSBundle mainBundle]pathForResource:@"bu"ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:bu];
    audio = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    //再生設定
    audio.volume = 0.1;//ボリューム
    audio.numberOfLoops = 1;//ループ回数
    [audio prepareToPlay];//再生準備

}

//------------------------------------------

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

//------------------------------------------

- (IBAction)GameButton:(id)sender {
    
    count++;
    _CountLavel.text = [NSString stringWithFormat:@"%dヒット",count];
    
    
    [audio play];
}

//------------------------------------------

//タイマーで行う処理
-(void)moveLabel:(NSTimer *)timer
{
    time--;
    _TaimLavel.text = [NSString stringWithFormat:@"残り%d秒",time];
    
    if (time == 0) {
        //タイマーを停止する
        [tm invalidate];
        _TaimLavel.text = @"終了";
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

//------------------------------------------

//アラート処理
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:
(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        time = 10;
        count = 0;
        //タイマー開始
        tm = [NSTimer scheduledTimerWithTimeInterval:1
                                              target:self
                                            selector:@selector(moveLabel:)
                                            userInfo:nil
                                             repeats:YES];
        //[tm fire];
    }else{
        
    }
}

@end
