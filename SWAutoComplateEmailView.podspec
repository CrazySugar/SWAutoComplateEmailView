Pod::Spec.new do |s|
  s.name             = "SWAutoComplateEmailView"
  s.version          = "0.1.0"
  s.summary          = "Email address auto completion."
  s.description      = <<-DESC
				Auto complete email address while inputting. A subview of UIScrollView.
                      	 DESC

  s.homepage         = "https://github.com/CrazySugar/SWAutoComplateEmailView"
  s.license          = 'MIT'
  s.author           = { "sugar" => "w90826@gmail.com" }
  s.source           = { :git => "https://github.com/CrazySugar/SWAutoComplateEmailView.git", :tag => s.version.to_s }

  s.platform     = :ios, '9.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'SWAutoComplateEmailView' => ['Pod/Assets/*.png']
  }

end
