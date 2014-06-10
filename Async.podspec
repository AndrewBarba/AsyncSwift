Pod::Spec.new do |s|
  s.name         = "Async"
  s.version      = "0.0.1"
  s.summary      = "An implementation of Node.js Async library written in Swift"
  s.description  = <<-DESC
                   An implementation of Node.js Async library written in Swift.
                   Async has become the standard in functional control flow...
                   DESC
  s.homepage     = "https://github.com/AndrewBarba/AsyncSwift"
  s.license      = "MIT"  
  s.author             = { "Andrew Barba" => "abarba.77@gmail.com" }
  s.source       = { :git => "https://github.com/AndrewBarba/AsyncSwift.git", :tag => "0.0.1" }
  s.source_files  = "Async", "Async/**/*.{h,m,swift}"
  s.exclude_files = "Async/**/*.{playground}"
  s.requires_arc = true
end
