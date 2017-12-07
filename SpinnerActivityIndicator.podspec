
Pod::Spec.new do |s|

  s.name         = "SpinnerActivityIndicator"
  s.version      = "0.0.1"
  s.summary      = "UIKit dynamics based activity indicator that works as real fidget spinner"

  s.description  = <<-DESC
                  UIKit dynamics based activity indicator that is much more
                  fun and interactive than default system one!
                   DESC

  s.homepage     = "https://github.com/tkach/SpinnerActivityIndicator"

  s.license      = { :type => "MIT" }


  s.author       = { "Alex Tkachenko" => "tkach2004@gmail.com" }
  s.platform     = :ios, "9.0"

  s.source       = { :git => "https://github.com/tkach/SpinnerActivityIndicator.git", :tag => "#{s.version}" }
  s.source_files  = ["Pod/*.{swift}", "Pod/**/*.{swift}" ]

end
