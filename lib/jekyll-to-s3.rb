module Jekyll::ToS3

  class Deploy

    EXTENSIONS = {
      '.css'  => 'text/css',
      '.gif'  => 'image/gif',
      '.html' => 'text/html',
      '.ico'  => 'image/x-icon',
      '.jpg'  => 'image/jpeg',
      '.js'   => 'application/javascript',
      '.pdf'  => 'application/pdf',
      '.png'  => 'image/png',
      '.ttf'  => 'application/x-font-ttf',
      '.woff' => 'application/font-woff',
      '.xml'  => 'application/atom+xml',
    }

    def initialize(region:, access_key_id:, secret_access_key:, bucket:)
      credentials = Aws::Credentials.new(
        access_key_id,
        secret_access_key
      )

      Aws.config.update(
        region:      region,
        credentials: credentials
      )

      @bucket    = Aws::S3::Resource.new.bucket(bucket)
      @root_path = "_site"
    end

    attr_reader :bucket, :root_path

    def deploy
      upload_directory(root_path)
      cleanup_bucket
    end

    private

    def upload_directory(path)
      Dir["#{path}/*"].each do |file|
        if File.directory?(file)
          upload_directory(file)
        elsif EXTENSIONS.keys.include?(File.extname(file).downcase)
          key = file.split("#{root_path}/").last
          puts "Uploading #{key}"
          upload_file(Pathname.new(file), key)
        end
      end
    end

    def upload_file(path, key)
      object = bucket.object(key)

      File.open(path, 'rb') do |file|
        object.put(
          body:         file,
          acl:          'public-read',
          content_type: EXTENSIONS[File.extname(path)]
        )
      end
    end

    def cleanup_bucket
      bucket.objects.each do |object|
        unless File.exists?("#{root_path}/#{object.key}")
          puts "Removing #{object.key}"

          object.delete
        end
      end
    end

  end

end
