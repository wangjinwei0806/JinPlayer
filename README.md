
# JinPlayer

播放的是时候,强制横屏,其他页面不会横屏,乐视,爱奇艺,类似的播放器..主要参考[KRVideoPlayer](https://github.com/36Kr-Mobile/KRVideoPlayer)和其他的例子,中和而成，可以快进，亮度调整。。

## Requirements

`iOS >= 6.0`

   ![效果图](https://cloud.githubusercontent.com/assets/3974508/12646311/2c08ed6c-c60a-11e5-9f72-9336f075925f.jpg)

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
## License

JinPlayer is available under the MIT license. See the LICENSE file for more info.   
