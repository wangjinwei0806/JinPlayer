
JinPlayer
====================
![License](https://img.shields.io/cocoapods/l/TWPhotoPicker.svg)
![Platform](https://img.shields.io/cocoapods/p/TWPhotoPicker.svg)

播放的是时候,强制横屏,其他页面不会横屏,乐视,爱奇艺,类似的播放器..主要参考[KRVideoPlayer](https://github.com/36Kr-Mobile/KRVideoPlayer)和其他的例子,中和而成，可以快进，亮度调整,UI 完成可以自定义..

## Screenshots
![image](https://cloud.githubusercontent.com/assets/3974508/12646311/2c08ed6c-c60a-11e5-9f72-9336f075925f.jpg)
   
## Requirements

`iOS >= 6.0`

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

Create player:

```
 MyPlayer *my=[[MyPlayer alloc] init];
```

Set video path:

```
 my.videoUrl=url;
```

Set video title:

```
my.videoTitle=@"测试";
```

Show it:

```
[self presentViewController:my animated:NO completion:^{
    }];
```

## Installation

JinPlayer is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```
pod "JinPlayer"
```
**Manually from GitHub**

1.Download the `WZMarqueeView.h` and `WZMarqueeView.m` files in th [Source directory](https://github.com/wangzz/WZMarqueeView/tree/master/WZMarqueeView)

2.Add both files to your Xcode project.

3.`#import WZMarqueeView.h` wherever you want to use the API.
## License

JinPlayer is available under the MIT license. See the LICENSE file for more info.   
