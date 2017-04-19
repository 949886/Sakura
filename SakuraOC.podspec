Pod::Spec.new do |s|
  s.name = 'SakuraOC'
  s.version = '0.0.1'
  s.summary = 'A beautiful and powerful frameworks like cherry blossom (Objective-C Version).'
  s.homepage = 'http://eclipse.moe'
  s.license = 'MIT'
  s.authors = { 'YaeSakura' => '949886@qq.com' }
  s.source = { :git => 'https://github.com/949886/Sakura.git', :branch => "Objective-C"}
  s.platform = :ios, '8.0'
  s.requires_arc = true
  s.default_subspec = 'Categories', 'UI'

  s.subspec "Categories" do |ss|
    ss.source_files = "Sakura/Categories/**/*.{h,m}"
    ss.frameworks = 'UIKit'
  end

  s.subspec "UI" do |ss|
    ss.source_files = "Sakura/UI/**/*.{h,m}"
  end

end
