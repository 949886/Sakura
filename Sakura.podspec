Pod::Spec.new do |s|

  s.name = 'Sakura'
  s.version = '0.0.6'
  s.summary = 'A beautiful and powerful frameworks like cherry blossom.'
  s.homepage = 'http://eclipse.moe'
  s.license = { :type => 'Copyright', :text => 'Copyright (c) 2017 Yae Sakura. All rights reserved.' }
  s.authors = { 'Buka' => '949886@qq.com' }
  s.source = { :git => 'https://github.com/949886/Sakura.git', :branch => "master"}
  s.platform = :ios, '8.0'
  s.requires_arc = true
  s.xcconfig    = { 'SWIFT_VERSION' => '3.0' }
  s.default_subspec = 'Extension', 'UI'

  s.subspec "Extension" do |ss|
    ss.source_files = "Sakura/Extension/**/*.{h,swift}"
    ss.frameworks = 'UIKit'
    ss.library = 'z'
  end

  s.subspec "UI" do |ss|
    ss.source_files = "Sakura/UI/**/*.{h,swift}"
  end

  s.subspec "OC" do |ss|
    ss.dependency 'SakuraOC'
  end

end
