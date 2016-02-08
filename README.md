
JinPlayer
====================
![License](https://img.shields.io/cocoapods/l/TWPhotoPicker.svg)
![Platform](https://img.shields.io/cocoapods/p/TWPhotoPicker.svg)

播放的是时候,强制横屏,其他页面不会横屏,乐视,爱奇艺,类似的播放器..主要参考[KRVideoPlayer](https://github.com/36Kr-Mobile/KRVideoPlayer)和其他的例子,中和而成，可以快进，亮度调整,UI 完成可以自定义..

## Screenshots
![image](https://cloud.githubusercontent.com/assets/3974508/12646311/2c08ed6c-c60a-11e5-9f72-9336f075925f.jpg)
## 以下 app 就是用的这个
[微窗口(精品,简单)](https://itunes.apple.com/us/app/wei-chuang-kou-jing-pin-jian/id1078191276?l=zh&ls=1&mt=8)
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
Examples-> podfile
```
platform :ios, '8.0'
target 'Examples' do
  pod 'JinPlayer', '~> 1.0.0'
end
```

## Manually from GitHub

1.Download the pod files in th [Source directory](https://github.com/wangjinwei0806/JinPlayer/tree/master/Pod)

2.Add files to your Xcode project.

3.`#import MyPlayer.h` wherever you want to use the API.

## License

JinPlayer is available under the MIT license. See the [LICENSE](https://github.com/wangjinwei0806/JinPlayer/blob/master/LICENSE) file for more info.   
