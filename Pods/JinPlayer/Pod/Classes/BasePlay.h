//
//  BasePlay.h
//  T
//
//  Created by macbook on 16/1/9.
//  Copyright © 2016年 testOne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BasePlay : UIView
@property (nonatomic, strong, readonly) UIView *topBar;
@property (nonatomic, strong, readonly) UIView *bottomBar;
@property (nonatomic, strong, readonly) UIButton *playButton;
@property (nonatomic, strong, readonly) UIButton *pauseButton;
@property (nonatomic, strong, readonly) UIButton *fullScreenButton;
@property (nonatomic, strong, readonly) UIButton *shrinkScreenButton;
@property (nonatomic, strong, readonly) UISlider *progressSlider;
@property (nonatomic, strong, readonly) UIButton *closeButton;
@property (nonatomic, strong, readonly) UILabel *timeLabel;
@property (nonatomic, strong, readonly) UIActivityIndicatorView *indicatorView;
@property (nonatomic, strong, readonly) UIView *bright;
//@property (nonatomic,strong,readonly) UIImageView *brightbg;
@property (nonatomic,strong,readonly) UISlider *brightSlider;

@property (nonatomic,strong,readonly) UILabel *titleLabel;
@property (nonatomic,strong,readonly)UIButton *shareButton;
@property (nonatomic,strong,readonly) UIButton *dowmButton;
//@property (nonatomic,readonly) UIView *leftview;
- (void)animateHide;
- (void)animateShow;
- (void)autoFadeOutControlBar;
- (void)cancelAutoFadeOutControlBar;
@end
