#
# Be sure to run `pod lib lint NKNetworker.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'NKNetworker'
  s.version          = '0.1.3'
  s.summary          = 'Implementing REST API requests based on decoded types'


  s.description      = <<-DESC
This template is designed to simplify and speed up the process of creating and processing REST API requests and responses with JSON body. Based on automatic generationof instances of types supporting Codable protocol
                       DESC

  s.homepage         = 'https://github.com/nkopilovskii/NKNetworker'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'nkopilovskii' => 'nikolay.k@powercode.us' }
  s.source           = { :git => 'https://github.com/nkopilovskii/NKNetworker.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/MKopilovskii'

  s.ios.deployment_target = '10.0'
  s.swift_version = '5.0'

  s.source_files = 'NKNetworker/Classes/**/*'
end
