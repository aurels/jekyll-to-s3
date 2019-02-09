# Jekyll to S3

Tool to deploy a Jekyll build to S3.

## Usage

Add gems to Gemfile :

    gem 'aws-sdk-s3'
    gem 'jekyll-to-s3'

Create a `deploy.rb` in your project :

    require 'bundler'
    
    Bundler.require
    
    Jekyll::ToS3::Deploy.new(
      region:            ENV['S3_REGION'],
      access_key_id:     ENV['S3_ACCESS_KEY_ID'],
      secret_access_key: ENV['S3_SECRET_ACCESS_KEY'],
      bucket:            ENV['S3_BUCKET']
    ).deploy

To deploy :

    bundle exec ruby deploy.rb
