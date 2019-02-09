require File.expand_path("../lib/jekyll-to-s3/version.rb", __FILE__)

Gem::Specification.new do |s|
  s.name          = "jekyll-to-s3"
  s.version       = JekyllToS3::VERSION
  s.authors       = ["Aurélien Malisart"]
  s.email         = ["jekyll-to-s3@aurels.be"]
  s.homepage      = "https://github.com/aurels/jekyll-to-s3"
  s.summary       = "Deploys a Jekyll build to S3."
  s.license       = "MIT"
  s.files         = ['lib/jekyll-to-s3.rb']
  s.test_files    = []
end
