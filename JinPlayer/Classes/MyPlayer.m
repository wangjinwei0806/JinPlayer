//
//  MyPlayer.m
//  T
//
//  Created by macbook on 16/1/9.
//  Copyright © 2016年 testOne. All rights reserved.
//

#import "MyPlayer.h"
#import "BasePlay.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AudioToolbox/AudioToolbox.h>
#import "ProgressHUD.h"
#import "MBProgressHUD.h"
#import <AVFoundation/AVFoundation.h>
CGFloat const gestureMinimumTranslation = 20.0;

typedef enum :NSInteger {
    kCameraMoveDirectionNone,
    kCameraMoveDirectionUp,
    kCameraMoveDirectionDown,
    kCameraMoveDirectionRight,
    kCameraMoveDirectionLeft
} CameraMoveDirection;

@interface MyPlayer ()
@property (nonatomic,strong)BasePlay *videoControl;
@property (nonatomic, strong) UIView *movieBackgroundView;
@property (nonatomic, assign) BOOL isFullscreenMode;
@property (nonatomic, assign) CGRect originFrame;
@property (nonatomic, strong) NSTimer *durationTimer;
@property (nonatomic,strong)   MPMoviePlayerController *moviePlayer;



@property (nonatomic,assign) CGFloat currentPointMockX;
@property (nonatomic,assign)CGFloat currentPointMockY;
@property (nonatomic,assign) BOOL isTouchLeft;
@property (nonatomic,assign)BOOL isBrightUIViewShowing;
@property (nonatomic,assign) UISlider *progressSlider;
@end
@implementation MyPlayer
{
    CGRect frame;
    BOOL isVerticalMoving;
    BOOL isHorizontalMoving;
    CameraMoveDirection direction;
    UISlider *progressSlider2;
    BOOL ishow;
}
- (void)dealloc
{
    [self cancelObserver];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super init];
    if (self) {
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
     [self configPage];

    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    UIPanGestureRecognizer *pi=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    [self.videoControl addGestureRecognizer:pi];

}
- (void)viewWillAppear:(BOOL)animated {
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = UIInterfaceOrientationLandscapeRight;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
    [super viewWillAppear:animated];
   
}
- (CameraMoveDirection)determineCameraDirectionIfNeeded:(CGPoint)translation
{
    if (direction != kCameraMoveDirectionNone)
        return direction;
    // determine if horizontal swipe only if you meet some minimum velocity
    if (fabs(translation.x) > gestureMinimumTranslation)
    {
        BOOL gestureHorizontal = NO;
        if (translation.y ==0.0)
            gestureHorizontal = YES;
        else
            gestureHorizontal = (fabs(translation.x / translation.y) >5.0);
        if (gestureHorizontal)
        {
            if (translation.x >0.0)
                return kCameraMoveDirectionRight;
            else
                return kCameraMoveDirectionLeft;
        }
    }
    // determine if vertical swipe only if you meet some minimum velocity
    else if (fabs(translation.y) > gestureMinimumTranslation)
    {
        BOOL gestureVertical = NO;
        if (translation.x ==0.0)
            gestureVertical = YES;
        else
            gestureVertical = (fabs(translation.y / translation.x) >5.0);
        if (gestureVertical)
        {
            if (translation.y >0.0)
                return kCameraMoveDirectionDown;
            else
                return kCameraMoveDirectionUp;
        }
    }
    return direction;
}



- (void)handleSwipe:(UIPanGestureRecognizer *)gesture
{
    CGPoint translation = [gesture translationInView:self.view];
    if (gesture.state ==UIGestureRecognizerStateBegan)
    {
        direction = kCameraMoveDirectionNone;
        self.currentPointMockX = 0.0;
        self.currentPointMockY = 0.0;
        isVerticalMoving = NO;
        isHorizontalMoving = NO;
    }
    else if (gesture.state == UIGestureRecognizerStateChanged && direction == kCameraMoveDirectionNone)
    {
        direction = [self determineCameraDirectionIfNeeded:translation];
        
        // ok, now initiate movement in the direction indicated by the user's gesture
        switch (direction) {
            case kCameraMoveDirectionDown:
                NSLog(@"Start moving down");
                isVerticalMoving = YES;
                isHorizontalMoving = NO;
                if (self.isTouchLeft)
                {
                    //[self animateBrightUIViewShow];
                    [self autoShowBright];
                }
                break;
            case kCameraMoveDirectionUp:
        
                
                NSLog(@"Start moving up");
                isVerticalMoving = YES;
                isHorizontalMoving = NO;
                //AndyLog(@"垂直移动");
                if (self.isTouchLeft)
                {
                    //[self animateBrightUIViewShow];
                       [self autoShowBright];
                }
                break;
            case kCameraMoveDirectionRight:
                NSLog(@"Start moving right");
                isVerticalMoving = NO;
                isHorizontalMoving = YES;
                [self progressSliderTouchBegan:self.videoControl.progressSlider];
                
                break;
            case kCameraMoveDirectionLeft:
                isVerticalMoving = NO;
                isHorizontalMoving = YES;
                [self progressSliderTouchBegan:self.videoControl.progressSlider];
                
                NSLog(@"Start moving left");
                break;
            default:
                break;
        }
    }
    else if (gesture.state == UIGestureRecognizerStateEnded)
    {
        if (isHorizontalMoving)
        {
            [self.moviePlayer pause];
            [self progressSliderTouchEnded:self.videoControl.progressSlider];
            [self.moviePlayer play];
            [ProgressHUD dismiss];
            
//            [UIView animateWithDuration:0.3 animations:^{
//                
//            }];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [UIView animateWithDuration:0.4 animations:^{
//                    [self.videoControl.indicatorView startAnimating];
//                } completion:^(BOOL finished) {
//                    [self.videoControl.indicatorView stopAnimating];
//                }];
//            });
         
        }
        else
        {
            if (isVerticalMoving)
            {
                if (self.isTouchLeft)
                {
                         //  NSLog(@"jieshu");
                    [self autoHiddentBright];
                   

                }
            }
        }
        
    }
    if (isVerticalMoving)
    {
        if (self.isTouchLeft)
        {
              NSLog(@"isTouchLeft");
            if (self.isBrightUIViewShowing == NO)
            {
            }
           
            //获取屏幕当前亮度，并赋值给可操控字段
            float Screenbrightness = [UIScreen mainScreen].brightness;
            
           // [self.videoControl showbrightanimation];
            
            if (translation.y >= self.currentPointMockY)
            {
                // AndyLog(@"向下移动");
                if (Screenbrightness - 0.03f >= -0.03f)
                {
                    NSLog(@"向下移动");
                 //    [self.videoControl showbrightanimation];
                   
                    Screenbrightness -= 0.03;
                    [UIScreen mainScreen].brightness = Screenbrightness;
                    self.videoControl.brightSlider.value=Screenbrightness;

                }
               
            }
            else
            {
                //AndyLog(@"向上移动");
                
                if (Screenbrightness + 0.03f <= 1.03f)
                {
                      NSLog(@"向下移动");
                   // [self showBright];
                    Screenbrightness += 0.03f;
                    [UIScreen mainScreen].brightness = Screenbrightness;
                         self.videoControl.brightSlider.value=Screenbrightness;
        
                }
            }
           // [self.videoControl autohiddenbright];
            
            //            if(fabs(self.currentPointMockY - translation.y) >= kVideoControlBrightUIViewSliderResponseInterval)
            //            {
            //                self.currentPointMockY = translation.y;
            //               // [self controlBrightUIViewSliderSquare:Screenbrightness];
            //            }
        }
        else{
            MPVolumeView *volumeView = [[MPVolumeView alloc] init];
            //  volumeView.backgroundColor=[UIColor clearColor];
            // volumeView.frame=CGRectMake(20, 380, 280, 30);
            //  volumeView.transform=CGAffineTransformMakeRotation(M_PI_2);
            for (UIView *aView in [volumeView subviews]) {
                if ([aView.class.description isEqualToString:@"MPVolumeSlider"]) {
                    progressSlider2 = (UISlider *)aView;
                   // progressSlider2.transform = CGAffineTransformMakeRotation(M_PI_2);
                   // aView.hidden=YES;
                    break;
                }
            }
            
            
            //   // float systemVolume = volumeSlider.value;
            
            CGFloat currentVolume = [[AVAudioSession sharedInstance] outputVolume];
            
            if (translation.y >self.currentPointMockY)
            {
                // AndyLog(@"向下移动");
                if (currentVolume - 0.03f >= -0.03f)
                {
                    currentVolume -= 0.03;
                    progressSlider2.value=currentVolume;
                }
            }
            else
            {
                //AndyLog(@"向上移动");
                
                if (currentVolume + 0.03f <= 1.03f)
                {
                    currentVolume += 0.03f;
                    //  self.musicPlayer.volume = currentVolume;
                    progressSlider2.value=currentVolume;
                }
            }
            //             [[MPMusicPlayerController applicationMusicPlayer] setVolume:currentVolume];
            self.currentPointMockY = translation.y;
            
            
        }
    }else if (isHorizontalMoving)
    {
        CGFloat proSliderMaxValue = self.videoControl.progressSlider.maximumValue;
        CGFloat proSliderMinValue =  self.videoControl.progressSlider.minimumValue;
        CGFloat stepProportion = self.moviePlayer.duration * 0.005f;
        CGFloat currentTime = self.videoControl.progressSlider.value;
        BOOL isSeekingForward = NO;
        NSLog(@"uuu--%f--%f",self.currentPointMockX,translation.x );
        
        if (translation.x >self.currentPointMockX)
        {
            isSeekingForward = YES;
            
            NSLog(@"向右移动");
           
            if (currentTime < proSliderMaxValue &&translation.x!=self.currentPointMockX)
            {
                self.videoControl.progressSlider.value+=stepProportion;
                 [ProgressHUD show:@"前进中"];
            }
            
            
        }
        else
        {
            isSeekingForward = NO;
            NSLog(@"向左移动");
            if (currentTime > proSliderMinValue&&translation.x!=self.currentPointMockX)
            {
                self.videoControl.progressSlider.value-=stepProportion;
                 [ProgressHUD show:@"后退中"];
            }
           
        }
        if (fabs(self.currentPointMockX - translation.x) > 0)
        {
            NSLog(@"----%f",self.currentPointMockX);
            //[self controlSeekDirectionImageView:isSeekingForward]; //前进
            
            self.currentPointMockX = translation.x;
        }
        
        [self progressSliderValueChanged:self.videoControl.progressSlider];
        
    }
    
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //[self showControls];
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)configPage{
    [self initMoviePlayer];    //初始化MoviePlayer
   // [self configPreloadPage];  //初始化播放钱预载页面
    //[self configNavControls];  //初始化上部控件
   // [self configBottomControls];
}
//-(void)showControls{
//
//}

-(void)setVideoUrl:(NSURL *)videoUrl{
    _videoUrl=videoUrl;
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight animated:YES];
   // [self initMoviePlayer];
}
-(void)initMoviePlayer{
    [MBProgressHUD showHUDAddedTo:self.videoControl animated:YES];
       [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight animated:YES];
    frame = self.view.bounds;
    if (self.view.bounds.size.width<self.view.bounds.size.height) {
        frame=CGRectMake(0, 0, self.view.bounds.size.height, self.view.bounds.size.width);
    }
    self.moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:self.videoUrl];
    [self.moviePlayer.view setFrame:frame];  // player的尺寸
    //[self.moviePlayer setFullscreen:YES];
    //self.moviePlayer.controlStyle=MPMovieControlStyleNone;
    [self.moviePlayer setScalingMode:MPMovieScalingModeAspectFit];
    [self.moviePlayer setControlStyle:MPMovieControlStyleNone];
    
    [self.view addSubview: self.moviePlayer.view];
    
    self.videoControl.frame=frame;
    [self.view addSubview: self.videoControl];

     [self configObserver];
    [self.moviePlayer prepareToPlay];
    [self.moviePlayer play];
    
    [self configControlAction];
    [self ListeningRotating];
    //[self fullScreenButtonClick];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

}

  

- (void)ListeningRotating{
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onDeviceOrientationChange)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil
     ];
    
}
- (void)onDeviceOrientationChange{
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)orientation;
    switch (interfaceOrientation) {
            /**        case UIInterfaceOrientationUnknown:
             NSLog(@"未知方向");
             break;
             */
        case UIInterfaceOrientationPortraitUpsideDown:{
            NSLog(@"第3个旋转方向---电池栏在下");
            //[self backOrientationPortrait];
        }
            break;
        case UIInterfaceOrientationPortrait:{
            NSLog(@"第0个旋转方向---电池栏在上");
          //  [self backOrientationPortrait];
        }
            break;
        case UIInterfaceOrientationLandscapeLeft:{
            NSLog(@"第2个旋转方向---电池栏在右");
            
           // [self setDeviceOrientationLandscapeLeft];
        }
            break;
        case UIInterfaceOrientationLandscapeRight:{
            
            NSLog(@"第1个旋转方向---电池栏在左");
            
           // [self setDeviceOrientationLandscapeRight];
            
        }
            break;
            
        default:
            break;
    }
    
}
- (void)configObserver
{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onMPMoviePlayerPlaybackStateDidChangeNotification) name:MPMoviePlayerPlaybackStateDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onMPMoviePlayerLoadStateDidChangeNotification) name:MPMoviePlayerLoadStateDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onMPMoviePlayerReadyForDisplayDidChangeNotification) name:MPMoviePlayerReadyForDisplayDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onMPMovieDurationAvailableNotification) name:MPMovieDurationAvailableNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onMPMovieDurationfinish) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hidden) name:MPMediaPlaybackIsPreparedToPlayDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(enterBackground:)
                                                 name:UIApplicationDidEnterBackgroundNotification object:nil];
}
- (void)enterBackground:(NSNotification *)notity {
    NSLog(@"enterbackground");
    [self.moviePlayer pause];
}
//这里可以添加进度条
-(void)hidden{
    NSLog(@"开始播放");
    //  [ProgressHUD dismiss];
    [MBProgressHUD  hideHUDForView:self.videoControl animated:YES];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}


- (void)cancelObserver
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)setVideoTitle:(NSString *)videoTitle{
    _videoTitle=videoTitle;
    self.videoControl.titleLabel.text=_videoTitle;
}

- (void)configControlAction
{
    [self.videoControl.playButton addTarget:self action:@selector(playButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.videoControl.pauseButton addTarget:self action:@selector(pauseButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.videoControl.closeButton addTarget:self action:@selector(closeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.videoControl.progressSlider addTarget:self action:@selector(progressSliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.videoControl.progressSlider addTarget:self action:@selector(progressSliderTouchBegan:) forControlEvents:UIControlEventTouchDown];
    [self.videoControl.progressSlider addTarget:self action:@selector(progressSliderTouchEnded:) forControlEvents:UIControlEventTouchUpInside];
    [self.videoControl.progressSlider addTarget:self action:@selector(progressSliderTouchEnded:) forControlEvents:UIControlEventTouchUpOutside];
    //一下是亮度
    [self.videoControl.brightSlider addTarget:self action:@selector(brightSliderValueChanged:) forControlEvents:UIControlEventValueChanged];//改变值
    [self.videoControl.brightSlider addTarget:self action:@selector(brightSliderTouchBegan:) forControlEvents:UIControlEventTouchDown];
    [self.videoControl.brightSlider addTarget:self action:@selector(brightSliderTouchEnded:) forControlEvents:UIControlEventTouchUpInside];
    [self.videoControl.brightSlider addTarget:self action:@selector(brightSliderTouchEnded:) forControlEvents:UIControlEventTouchUpOutside];
 
    
   [self setProgressSliderMaxMinValues];
    [self setBrightSliderCurrent];
  [self monitorVideoPlayback];
}

-(void)onMPMovieDurationfinish{
   // [self dismiss];
   // self.moviePlayer
}
-(void)tapleft{

}
-(void)configPreloadPage{

}
-(void)configNavControls{

}
-(void)configBottomControls{

}


- (void)onMPMoviePlayerPlaybackStateDidChangeNotification
{
    if (self.moviePlayer.playbackState == MPMoviePlaybackStatePlaying) {
        self.videoControl.pauseButton.hidden = NO;
        self.videoControl.playButton.hidden = YES;
        [self startDurationTimer];
        [self.videoControl.indicatorView stopAnimating];
        [self.videoControl autoFadeOutControlBar];
          [self.videoControl.indicatorView stopAnimating];
    }
    else if(self.moviePlayer.playbackState==MPMoviePlaybackStateSeekingForward){
        NSLog(@"qian");
        // [self.videoControl.indicatorView startAnimating];
    }
    else {
        self.videoControl.pauseButton.hidden = YES;
        self.videoControl.playButton.hidden = NO;
        [self stopDurationTimer];
        if (self.moviePlayer.playbackState == MPMoviePlaybackStateStopped) {
            [self.videoControl animateShow];
        }
    }
}

- (void)onMPMoviePlayerLoadStateDidChangeNotification
{
    if (self.moviePlayer.loadState & MPMovieLoadStateStalled) {
        [self.videoControl.indicatorView startAnimating];
    }
}
- (void)startDurationTimer
{
    self.durationTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(monitorVideoPlayback) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.durationTimer forMode:NSDefaultRunLoopMode];
}

- (void)stopDurationTimer
{
    [self.durationTimer invalidate];
}

- (void)fadeDismissControl
{
    [self.videoControl animateHide];
}

- (void)onMPMoviePlayerReadyForDisplayDidChangeNotification
{
    
}

- (void)onMPMovieDurationAvailableNotification
{
    [self setProgressSliderMaxMinValues];
}

- (void)playButtonClick
{
    [self.moviePlayer play];
    self.videoControl.playButton.hidden = YES;
    self.videoControl.pauseButton.hidden = NO;
    
}

- (void)pauseButtonClick
{
    [self.moviePlayer pause];
    self.videoControl.playButton.hidden = NO;
    self.videoControl.pauseButton.hidden = YES;
}

- (void)closeButtonClick
{
    [self.moviePlayer stop];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:NO completion:nil];
    });
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = UIInterfaceOrientationLandscapeRight;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)fullScreenButtonClick
{
    [self.moviePlayer stop];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:NO completion:nil];
    });
   // [self dismissViewControllerAnimated:YES completion:nil];
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = UIInterfaceOrientationLandscapeRight;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
      [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
//    if (self.isFullscreenMode) {
//        return;
//    }
//    self.originFrame = self.view.frame;
//    CGFloat height = [[UIScreen mainScreen] bounds].size.width;
//    CGFloat width = [[UIScreen mainScreen] bounds].size.height;
//    CGRect frame = CGRectMake((height - width) / 2, (width - height) / 2, width, height);;
//    [UIView animateWithDuration:0.3f animations:^{
//        self.frame = frame;
//        [self.view setTransform:CGAffineTransformMakeRotation(M_PI_2)];
//    } completion:^(BOOL finished) {
//        self.isFullscreenMode = YES;
//        self.videoControl.fullScreenButton.hidden = YES;
//        self.videoControl.shrinkScreenButton.hidden = NO;
//    }];
}

//- (void)shrinkScreenButtonClick
//{
//    if (!self.isFullscreenMode) {
//        return;
//    }
//    [UIView animateWithDuration:0.3f animations:^{
//        [self.view setTransform:CGAffineTransformIdentity];
//        self.frame = self.originFrame;
//    } completion:^(BOOL finished) {
//        self.isFullscreenMode = NO;
//        self.videoControl.fullScreenButton.hidden = NO;
//        self.videoControl.shrinkScreenButton.hidden = YES;
//    }];
//}

- (void)setProgressSliderMaxMinValues {
    CGFloat duration = self.moviePlayer.duration;
    self.videoControl.progressSlider.minimumValue = 0.f;
    self.videoControl.progressSlider.maximumValue = duration;
}
-(void)setBrightSliderCurrent{
    CGFloat current=[UIScreen mainScreen].brightness;
    self.videoControl.brightSlider.value=current;
    self.videoControl.brightSlider.minimumValue=0.f;
    self.videoControl.brightSlider.maximumValue=1.f;
}

-(void)brightSliderValueChanged:(UISlider *)slider{

}
-(void)brightSliderTouchBegan:(UISlider *)slider;
{

}
-(void)brightSliderTouchEnded:(UISlider *)slider
{

}

- (void)progressSliderTouchBegan:(UISlider *)slider {
    [self.moviePlayer pause];
    [self.videoControl cancelAutoFadeOutControlBar];
}

- (void)progressSliderTouchEnded:(UISlider *)slider {
    [self.moviePlayer  setCurrentPlaybackTime:floor(slider.value)];
    [self.moviePlayer  play];
    [self.videoControl autoFadeOutControlBar];
}

- (void)progressSliderValueChanged:(UISlider *)slider {
    double currentTime = floor(slider.value);
    double totalTime = floor(self.moviePlayer.duration);
    [self setTimeLabelValues:currentTime totalTime:totalTime];
}

- (void)monitorVideoPlayback
{
    double currentTime = floor(self.moviePlayer.currentPlaybackTime);
    double totalTime = floor(self.moviePlayer.duration);
    [self setTimeLabelValues:currentTime totalTime:totalTime];
    self.videoControl.progressSlider.value = ceil(currentTime);
}
#pragma mark -time
- (void)setTimeLabelValues:(double)currentTime totalTime:(double)totalTime {
   // float _X=NAN;
    if (!isnan(currentTime)&&!isnan(totalTime)) {

    double minutesElapsed = floor(currentTime / 60.0);
    double secondsElapsed = fmod(currentTime, 60.0);
    NSString *timeElapsedString = [NSString stringWithFormat:@"%02.0f:%02.0f", minutesElapsed, secondsElapsed];
    
    double minutesRemaining = floor(totalTime / 60.0);;
    double secondsRemaining = floor(fmod(totalTime, 60.0));;
    NSString *timeRmainingString = [NSString stringWithFormat:@"%02.0f:%02.0f", minutesRemaining, secondsRemaining];
    
    self.videoControl.timeLabel.text = [NSString stringWithFormat:@"%@/%@",timeElapsedString,timeRmainingString];
    }
}
#pragma mark - Property

- (BasePlay *)videoControl
{
    if (!_videoControl) {
        _videoControl = [[BasePlay alloc] init];
    }
    return _videoControl;
}

- (UIView *)movieBackgroundView
{
    if (!_movieBackgroundView) {
        _movieBackgroundView = [UIView new];
        _movieBackgroundView.alpha = 0.0;
        _movieBackgroundView.backgroundColor = [UIColor blackColor];
    }
    return _movieBackgroundView;
}








#pragma mark - 控制旋转

- (BOOL)shouldAutorotate
{
    return  NO;
}
// before ios6
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touc=[touches anyObject];
   CGPoint pont=[touc locationInView:self.view];
    double w=frame.size.width*0.3;
    double curr=pont.x;
    if (curr<=w) {
        self.isTouchLeft=true;
        
    }else{
        self.isTouchLeft=false;
    }
}


-(void)autoHiddentBright{
    [UIView animateWithDuration:0.3 animations:^{
        self.videoControl.bright.alpha=0;
    }];
}
-(void)autoShowBright{
    [UIView animateWithDuration:0.3 animations:^{
        self.videoControl.bright.alpha=1;
    }];
}
@end
