#
# Be sure to run `pod lib lint Tabula.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = "Tabula"
    s.version          = "0.1.0"
    s.summary          = "A short description of Tabula."
    s.description      = <<-DESC
    An optional longer description of Tabula
    
    * Markdown format.
    * Don't worry about the indent, we strip it!
    DESC
    s.homepage         = "https://github.com/<GITHUB_USERNAME>/Tabula"
    # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
    s.license          = 'MIT'
    s.author           = { "Josef Materi" => "josef.materi@gmail.com" }
    s.source           = { :git => "https://github.com/<GITHUB_USERNAME>/Tabula.git", :tag => s.version.to_s }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
    
    s.platform     = :ios, '8.0'
    s.requires_arc = true
    
    s.resource_bundles = {
        'Tabula' => ['Pod/Assets/*.png']
    }
    
    s.subspec "Core" do |ss|
        ss.source_files  = 'Pod/Classes/*.swift'
        ss.framework  = 'Foundation'
        ss.dependency 'PureLayout'
    end
end


