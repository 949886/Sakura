Pod::Spec.new do |s|
  s.name = 'Sakura'
  s.version = '0.0.1'
  s.summary = 'A beautiful and powerful frameworks like cherry blossom.'
  s.homepage = 'http://eclipse.moe'
  s.license = 'MIT'
  s.authors = { 'YaeSakura' => '949886@qq.com' }
  s.source = { :git => 'https://github.com/949886/Sakura.git', :tag => s.version}
  s.platform = :ios, '8.0'
  s.requires_arc = true
  s.source_files = 'Sakura/**/*.{h,swift}'
  s.exclude_files = 'SakuraTests/**/*.swift'
  s.frameworks = 'Foundation'

  s.subspec 'ObjC' do |objc|
    objc.source = { :git => 'https://github.com/949886/Sakura.git', :tag => s.version}
    objc.source_files = 'Sakura/**/*.{h,m}'
    objc.public_header_files = 'Sakura/**/*.{h}'
  end
end
