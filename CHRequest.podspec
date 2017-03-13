Pod::Spec.new do |s|
  s.name             = 'CHRequest'
  s.version          = '0.1.4'
  s.summary          = 'Network framework base on Alamofire in Swift'

  s.homepage         = 'https://github.com/chausson/CHRequest'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Chausson' => '232564026@qq.com' }
  s.source           = { :git => 'https://github.com/chausson/CHRequest.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'CHRequest/Classes/**/*'
  # s.resources = 'CHNetwork/Assets/**/*'
  
  s.dependency 'HandyJSON', '~> 1.6.0'
  s.dependency 'Result'
  s.dependency 'Alamofire', '~> 4.1'
end
