Pod::Spec.new do |s|
  s.name             = "PASOptionParser"
  s.version          = "0.0.1"
  s.summary          = "A block based, no thrills option parser to make CLI in Objective-C slightly less painful."
  s.description      = <<-DESC
						I didn't really like the interfaces of the existing libs and I had an evening to play with.
						
						This is almost certainly not the right pod for you and I would recommend shopping around before using this pod.
                       DESC
  s.homepage         = "https://github.com/paulsamuels/PASOptionParser"
  s.license          = 'MIT'
  s.author           = { "Paul Samuels" => "paulio1987@gmail.com" }
  s.source           = { :git => "https://github.com/paulsamuels/PASOptionParser.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/paulio87'

  s.platform     = :osx
  s.requires_arc = true

  s.source_files = 'Pod/Classes'
  s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'Foundation'
end
