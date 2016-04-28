

Pod::Spec.new do |s|

  s.name         = "JinPlayer"
  s.version      = "1.0.2"
  s.summary      = "JinPlayer"
  s.description  = <<-DESC
                   It is a Player used on iOS, which implement by Objective-C.  
                   DESC

  s.homepage     = "https://github.com/wangjinwei0806/JinPlayer"

  s.license      = "MIT"
  s.author             = { "wangjinwei" => "21418925@qq.com" }
  s.platform     = :ios, "6.0"

  s.source       = { :git => "https://github.com/wangjinwei0806/JinPlayer.git", :tag => s.version.to_s }

    s.source_files = 'Pod/Classes/**/*'

   s.resource  = "Pod/Assets/*.png"

   s.requires_arc = true

end