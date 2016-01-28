//
//  ViewController.m
//  Examples
//
//  Created by macbook on 16/1/28.
//  Copyright © 2016年 testOne. All rights reserved.
//

#import "ViewController.h"
#import "MyPlayer.h"
@interface ViewController ()
@property (nonatomic,strong)MyPlayer *player;
@end

@implementation ViewController
-(void)btnPlay{
    
    NSURL *videoURL = [NSURL URLWithString:@"http://7rflo2.com2.z0.glb.qiniucdn.com/568b5a4e727df.mp4"];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self startPlayWithUrl:videoURL];
    });
}
- (void)viewDidLoad {
    [super viewDidLoad];
       [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.view.backgroundColor=[UIColor whiteColor];
   CGFloat w= [UIScreen mainScreen].bounds.size.width;
    UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(w/2-100, 200, 200, 200)];
    [btn setTitle:@"远程播放横屏" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor yellowColor]];
    [self.view addSubview:btn];
      [btn addTarget:self action:@selector(btnPlay) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)startPlayWithUrl:(NSURL *)url{
    // self.view.alpha=0;
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    //MyPlayer *my= [self.childViewControllers firstObject];
    NSLog(@"%@",self.childViewControllers);
    
    MyPlayer *my=[[MyPlayer alloc] init];
    my.videoUrl=url;
    my.videoTitle=@"测试";
    //   my.modalPresentationStyle=UIModalPresentationOverCurrentContext;
    //[self.view addSubview:my.view];
    //[[[UIApplication sharedApplication].windows firstObject] addSubview:my.view]
    [self presentViewController:my animated:NO completion:^{
        // self.view.alpha=1;
        // self.view.hidden=false;
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}


- (void)ListeningRotating{
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onDeviceOrientationChange)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil
     ];
    
}

@end
