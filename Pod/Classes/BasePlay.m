//
//  BasePlay.m
//  T
//
//  Created by macbook on 16/1/9.
//  Copyright © 2016年 testOne. All rights reserved.
//
#define MAS_SHORTHAND
#import "BasePlay.h"
#import <Masonry/Masonry.h>
static const CGFloat kVideoControlBarHeight = 40.0;
static const CGFloat kVideoControlAnimationTimeinterval = 0.3;
static const CGFloat kVideoControlTimeLabelFontSize = 10.0;
static const CGFloat kVideoControlBarAutoFadeOutTimeinterval = 5.0;

@interface BasePlay ()

@property (nonatomic, strong) UIView *topBar;
@property (nonatomic, strong) UIView *bottomBar;
@property (nonatomic, strong) UIButton *playButton;
@property (nonatomic, strong) UIButton *pauseButton;
@property (nonatomic, strong) UIButton *fullScreenButton;
@property (nonatomic, strong) UIButton *shrinkScreenButton;
@property (nonatomic, strong) UISlider *progressSlider;
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, assign) BOOL isBarShowing;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;
@property (nonatomic,strong) UIView *bright;
//@property (nonatomic,strong) UIImageView *brightbg;
@property (nonatomic,strong) UISlider *brightSlider;
//@property (nonatomic,strong) UIView *leftview;
@property (nonatomic, assign) BOOL isbrightshow;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong)UIButton *shareButton;
@property (nonatomic,strong) UIButton *dowmButton;

@end

@implementation BasePlay

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.topBar];
        [self.topBar addSubview:self.closeButton];
        
        [self.topBar addSubview:self.titleLabel];
        [self.topBar addSubview:self.shareButton];
        [self.topBar addSubview:self.dowmButton];
        
        
        [self addSubview:self.bottomBar];
        [self.bottomBar addSubview:self.playButton];
        [self.bottomBar addSubview:self.pauseButton];
        
        self.pauseButton.hidden = YES;
        
        [self.bottomBar addSubview:self.progressSlider];
        [self.bottomBar addSubview:self.timeLabel];
        [self addSubview:self.indicatorView];
        
        //新增的
        [self addSubview:self.bright];
       // [self.bright addSubview:self.brightbg];
        [self.bright addSubview:self.brightSlider];
        
        //[self addSubview:self.leftview];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
//    self.topBar.frame = CGRectMake(CGRectGetMinX(self.bounds), CGRectGetMinY(self.bounds)-22, CGRectGetMaxX(self.bounds), kVideoControlBarHeight+22);
//
//    self.closeButton.frame = CGRectMake(CGRectGetMinX(self.bottomBar.bounds), CGRectGetMinX(self.bounds)+30, CGRectGetMaxX(self.closeButton.bounds), CGRectGetMaxY(self.closeButton.bounds));
//    
//    
//    //标题
//    
//    self.titleLabel.frame=CGRectMake(CGRectGetWidth(self.closeButton.bounds), CGRectGetMinX(self.bounds)+30, CGRectGetMaxX(self.closeButton.bounds), CGRectGetMaxY(self.closeButton.bounds));
//    
//    //分享
//    self.shareButton.frame=CGRectMake(CGRectGetWidth(self.bottomBar.bounds)-100, CGRectGetMinX(self.bounds)+30,CGRectGetMaxX(self.shareButton.bounds), CGRectGetMaxY(self.shareButton.bounds));
//    //下载
//    
//     self.dowmButton.frame=CGRectMake(CGRectGetWidth(self.bottomBar.bounds)-150, CGRectGetMinX(self.bounds)+30,CGRectGetMaxX(self.dowmButton.bounds), CGRectGetMaxY(self.dowmButton.bounds));
    
  //  self.bottomBar.frame = CGRectMake(CGRectGetMinX(self.bounds), CGRectGetMaxY(self.bounds) - kVideoControlBarHeight, CGRectGetMaxX(self.bounds), kVideoControlBarHeight);
    
    CGFloat dt=0;
    CGFloat dw=self.bounds.size.width;
    CGFloat dh=self.bounds.size.height;
    
    
    self.topBar.translatesAutoresizingMaskIntoConstraints=NO;
    
    self.bottomBar.translatesAutoresizingMaskIntoConstraints=NO;
    
    self.progressSlider.translatesAutoresizingMaskIntoConstraints=NO;
    self.pauseButton.translatesAutoresizingMaskIntoConstraints=NO;
    self.playButton.translatesAutoresizingMaskIntoConstraints=NO;
    self.timeLabel.translatesAutoresizingMaskIntoConstraints=NO;
    self.bright.translatesAutoresizingMaskIntoConstraints=NO;
    self.brightSlider.translatesAutoresizingMaskIntoConstraints=NO;
    self.closeButton.translatesAutoresizingMaskIntoConstraints=NO;
    self.shareButton.translatesAutoresizingMaskIntoConstraints=NO;
    self.dowmButton.translatesAutoresizingMaskIntoConstraints=NO;
    self.titleLabel.translatesAutoresizingMaskIntoConstraints=NO;
    
    //顶部
    [self.topBar makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(dt));
        make.right.equalTo(@(dt));
        make.left.equalTo(@(dt));
        make.width.equalTo(@(dw));
        make.height.equalTo(@(kVideoControlBarHeight+10));
    }];
    //返回
    
    [self.closeButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(10));
      //  make.right.equalTo(@(10));
        make.left.equalTo(@(5));
        make.width.equalTo(@(50));
        make.height.equalTo(@(50));
    }];
    [self.titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(10));
        //  make.right.equalTo(@(10));
        make.left.equalTo(@(50));
       // make.width.equalTo(@(30));
        make.height.equalTo(@(50));
    }];
    //下载
    [self.dowmButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(10));
        make.right.equalTo(@(-60));
       // make.left.equalTo(@(10));
        make.width.equalTo(@(50));
        make.height.equalTo(@(50));
    }];
    //分享
    [self.shareButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(10));
          make.right.equalTo(@(-10));
       // make.left.equalTo(@(10));
        make.width.equalTo(@(50));
        make.height.equalTo(@(50));
    }];
    
    //底部
    [self.bottomBar makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(dh-kVideoControlBarHeight));
        make.right.equalTo(@(dt));
        make.left.equalTo(@(dt));
        make.width.equalTo(@(dw));
        make.height.equalTo(@(kVideoControlBarHeight));
    }];
    //精度条
    
    [self.progressSlider makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(15));
        make.right.equalTo(@(-10));
        make.left.equalTo(@(kVideoControlBarHeight));
        make.width.equalTo(@(dt-kVideoControlBarHeight));
        make.height.equalTo(@(5));
    }];
    //暂停
    [self.pauseButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(1));
        make.left.equalTo(@(5));
        make.width.equalTo(@(36));
        make.height.equalTo(@(57));
        make.bottom.equalTo(@-2);
    }];
    //播放
    [self.playButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(1));
        make.left.equalTo(@(5));
        make.width.equalTo(@(36));
        make.height.equalTo(@(57));
        make.bottom.equalTo(@-2);
    }];
    //时间
    
    [self.timeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(20));
        make.left.equalTo(@(dw-110));
        make.width.equalTo(@(100));
      //  make.height.equalTo(@(200));
        make.bottom.equalTo(@0);
    }];
    //亮度
    [self.bright makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);//子view在父view中间
        make.size.mas_equalTo(CGSizeMake(125, 125));//子view长300，高200
    }];
    //亮度进度条
    
    [self.brightSlider makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(95));
        make.left.equalTo(@(15));
          make.right.equalTo(@(-15));
        make.width.equalTo(@(100));
        make.height.equalTo(@(5));
        make.bottom.equalTo(@0);
    }];
    
    
//    self.playButton.frame = CGRectMake(CGRectGetMinX(self.bottomBar.bounds), CGRectGetMaxY(self.bottomBar.bounds)/2 - CGRectGetMaxY(self.playButton.bounds)/2, CGRectGetMaxX(self.playButton.bounds), CGRectGetMaxY(self.playButton.bounds));
//    
//    self.pauseButton.frame = self.playButton.frame;
//    
//    
//    self.progressSlider.frame = CGRectMake(CGRectGetMaxX(self.playButton.bounds), CGRectGetMaxY(self.bottomBar.bounds)/2 - CGRectGetMaxY(self.progressSlider.bounds)/2, CGRectGetMaxX(self.bounds) - CGRectGetMaxX(self.playButton.bounds)-10, CGRectGetMaxY(self.progressSlider.bounds));
//    
//    self.timeLabel.frame = CGRectMake(CGRectGetMidX(self.progressSlider.frame)-50, CGRectGetMaxY(self.progressSlider.frame) -10, CGRectGetMidX(self.progressSlider.frame), CGRectGetMaxY(self.timeLabel.bounds));
//    self.indicatorView.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
//    
//    
//    self.bright.frame=CGRectMake(CGRectGetWidth(self.bounds)/2-60, CGRectGetHeight(self.bounds)/2-60, 125, 125);
//
//    self.brightSlider.frame=CGRectMake(10, 105, 105, 5);
}

- (void)didMoveToSuperview
{
    [super didMoveToSuperview];
    self.isBarShowing = YES;
   // self.isbrightshow=YES;
}

- (void)animateShow
{
    if (self.isBarShowing) {
        return;
    }
    [UIView animateWithDuration:kVideoControlAnimationTimeinterval animations:^{
        self.topBar.alpha = 1.0;
        self.bottomBar.alpha = 1.0;
    } completion:^(BOOL finished) {
        self.isBarShowing = YES;
        [self autoFadeOutControlBar];
    }];
}
- (void)animateHide
{
    if (!self.isBarShowing) {
        return;
    }
    [UIView animateWithDuration:kVideoControlAnimationTimeinterval animations:^{
        self.topBar.alpha = 0.0;
        self.bottomBar.alpha = 0.0;
    } completion:^(BOOL finished) {
        self.isBarShowing = NO;
    }];
}
- (void)autoFadeOutControlBar
{
    if (!self.isBarShowing) {
        return;
    }
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(animateHide) object:nil];
    [self performSelector:@selector(animateHide) withObject:nil afterDelay:kVideoControlBarAutoFadeOutTimeinterval];
}

- (void)cancelAutoFadeOutControlBar
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(animateHide) object:nil];
}


- (void)onTap:(UITapGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateRecognized) {
        if (self.isBarShowing) {
            [self animateHide];
        } else {
            [self animateShow];
        }
    }
}

#pragma mark - Property

- (UIView *)topBar
{
    if (!_topBar) {
        _topBar = [UIView new];
       // _topBar.backgroundColor = [UIColor redColor];
         _topBar.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    }
    return _topBar;
}
-(UIView *)bright{
    if (!_bright) {
        _bright=[UIView new];
        _bright.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"video_brightness_bg"]];
        _bright.alpha=0;
        
    }
    return _bright;
}
- (UIView *)bottomBar
{
    if (!_bottomBar) {
        _bottomBar = [UIView new];
        _bottomBar.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    }
    return _bottomBar;
}

- (UIButton *)playButton
{
    if (!_playButton) {
        _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playButton setImage:[UIImage imageNamed:[self videoImageName:@"kr-video-player-play"]] forState:UIControlStateNormal];
        _playButton.bounds = CGRectMake(0, 0, kVideoControlBarHeight, kVideoControlBarHeight);
    }
    return _playButton;
}

- (UIButton *)pauseButton
{
    if (!_pauseButton) {
        _pauseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_pauseButton setImage:[UIImage imageNamed:[self videoImageName:@"kr-video-player-pause"]] forState:UIControlStateNormal];
        _pauseButton.bounds = CGRectMake(0, 0, kVideoControlBarHeight, kVideoControlBarHeight);
    }
    return _pauseButton;
}

- (UIButton *)fullScreenButton
{
    if (!_fullScreenButton) {
        _fullScreenButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_fullScreenButton setImage:[UIImage imageNamed:[self videoImageName:@"kr-video-player-fullscreen"]] forState:UIControlStateNormal];
        _fullScreenButton.bounds = CGRectMake(0, 0, kVideoControlBarHeight, kVideoControlBarHeight);
    }
    return _fullScreenButton;
}

- (UIButton *)shrinkScreenButton
{
    if (!_shrinkScreenButton) {
        _shrinkScreenButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shrinkScreenButton setImage:[UIImage imageNamed:[self videoImageName:@"kr-video-player-shrinkscreen"]] forState:UIControlStateNormal];
        _shrinkScreenButton.bounds = CGRectMake(0, 0, kVideoControlBarHeight, kVideoControlBarHeight);
    }
    return _shrinkScreenButton;
}

- (UISlider *)progressSlider
{
    if (!_progressSlider) {
        _progressSlider = [[UISlider alloc] init];
        [_progressSlider setThumbImage:[UIImage imageNamed:[self videoImageName:@"kr-video-player-point"]] forState:UIControlStateNormal];
        [_progressSlider setMinimumTrackTintColor:[UIColor whiteColor]];
        [_progressSlider setMaximumTrackTintColor:[UIColor lightGrayColor]];
        _progressSlider.value = 0.f;
        _progressSlider.continuous = YES;
    }
    return _progressSlider;
}



-(UISlider *)brightSlider{
    if (!_brightSlider) {
        _brightSlider = [[UISlider alloc] init];
        UIImage *left=[UIImage imageNamed:@"video_num_front.png"];
        UIImage *right=[UIImage imageNamed:@"video_num_bg.png"];
          [_brightSlider setThumbImage:[UIImage imageNamed:[self videoImageName:@"kr-video-player-point"]] forState:UIControlStateNormal];
        [_brightSlider setMinimumTrackImage:left forState:UIControlStateNormal];
        [_brightSlider setMaximumTrackImage:right forState:UIControlStateNormal];
        _brightSlider.minimumValue=0.f;
        _brightSlider.maximumValue=1.0f;
        _brightSlider.continuous = YES;
    }
    return  _brightSlider;
}



- (UIButton *)closeButton
{
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton setImage:[UIImage imageNamed:[self videoImageName:@"player_back"]] forState:UIControlStateNormal];
        _closeButton.bounds = CGRectMake(0, 0, kVideoControlBarHeight, kVideoControlBarHeight);
    }
    return _closeButton;
}

-(UIButton *)shareButton{
    if (!_shareButton) {
        _shareButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_shareButton setImage:[UIImage imageNamed:[self videoImageName:@"player_share_top_p"]] forState:UIControlStateNormal];
        _shareButton.bounds = CGRectMake(0, 0, kVideoControlBarHeight, kVideoControlBarHeight);
    }
    return _shareButton;
}

-(UIButton *)dowmButton{
    if (!_dowmButton) {
        _dowmButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_dowmButton setImage:[UIImage imageNamed:[self videoImageName:@"player_down_p"]] forState:UIControlStateNormal];
        _dowmButton.bounds = CGRectMake(0, 0, kVideoControlBarHeight, kVideoControlBarHeight);
    }
    return _dowmButton;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [UILabel new];
        _timeLabel.backgroundColor = [UIColor clearColor];
        _timeLabel.font = [UIFont systemFontOfSize:kVideoControlTimeLabelFontSize];
        _timeLabel.textColor = [UIColor whiteColor];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.text=@"00:00/00:00";
        _timeLabel.bounds = CGRectMake(0, 0, kVideoControlTimeLabelFontSize, kVideoControlTimeLabelFontSize);
    }
    return _timeLabel;
}
#pragma mark ---标题
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel=[UILabel new];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont systemFontOfSize:kVideoControlTimeLabelFontSize];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.text=@"1111sssssssssssssssssss";
        _titleLabel.textAlignment = NSTextAlignmentRight;
        _titleLabel.bounds = CGRectMake(0, 0, kVideoControlTimeLabelFontSize, kVideoControlTimeLabelFontSize);
    }
    return _titleLabel;
}

- (UIActivityIndicatorView *)indicatorView
{
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [_indicatorView stopAnimating];
    }
    return _indicatorView;
}

#pragma mark - Private Method

- (NSString *)videoImageName:(NSString *)name
{
    if (name) {
        NSString *path = [NSString stringWithFormat:@"%@",name];
        return path;
    }
    return nil;
}

@end
