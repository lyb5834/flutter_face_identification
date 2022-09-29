#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_face_identification.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_face_identification'
  s.version          = '0.0.1'
  s.summary          = 'ca 人脸识别插件'
  s.description      = <<-DESC
ca 人脸识别插件
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'YBAliAuthSDK', '~> 2.12.9'
  s.dependency 'MBProgressHUD'

  s.platform = :ios, '10.0'

  s.vendored_frameworks = 'Libs/DYRZSDK.xcframework',
  'Libs/HuiYanSDK.framework',
  'Libs/AFServiceSDK.framework',
  'Libs/ytFrameworks/tnnliveness.framework',
  'Libs/ytFrameworks/YTCommonLiveness.framework',
  'Libs/ytFrameworks/YTFaceAlignmentTinyLiveness.framework',
  'Libs/ytFrameworks/YTFaceDetectorLiveness.framework',
  'Libs/ytFrameworks/YTFaceLiveReflect.framework',
  'Libs/ytFrameworks/YTFaceTrackerLiveness.framework',
  'Libs/ytFrameworks/YTPoseDetector.framework',
  'Libs/ytFrameworks/YtSDKKitActionLiveness.framework',
  'Libs/ytFrameworks/YtSDKKitFramework.framework',
  'Libs/ytFrameworks/YtSDKKitReflectLiveness.framework',
  'Libs/ytFrameworks/YtSDKKitSilentLiveness.framework'

  s.vendored_libraries = 'Libs/libTuringShieldCamRisk.a'

  s.frameworks = 'CoreGraphics','Accelerate'

  s.libraries = 'bz2','c++','iconv','resolv','z'

  s.static_framework = false
  s.resources = ['Assets/*']

  # Flutter.framework does not contain a i386 slice.
#   s.pod_target_xcconfig = {'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64'   }
#   s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  s.swift_version = '5.0'
end
