
Pod::Spec.new do |s|

  s.name         = "Glow"
  s.version      = "0.3.0"
  s.summary      = "A tool for use skeleton animated view in UIKit."

  s.description  = <<-DESC
                   This repo let you write some template code to get a skeletonView, 
                   on which you can play shimmer, glow or other animations
                   
                   DESC

  s.homepage     = "https://github.com/foxsin10/Glow"

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.authors            = { "foxsion10" => "yzjcnn@gmail.com" }
  s.social_media_url   = "https://github.com/foxsin10"

  s.swift_versions = ['5.4']

  s.ios.deployment_target = "11.0"

  s.source       = { :git => "https://github.com/foxsin10/Glow.git", :tag => s.version }
  s.source_files  = ["Sources/**/*.swift"]

  s.requires_arc = true
  s.weak_frameworks = "UIKit"
end