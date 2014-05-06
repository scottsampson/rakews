require 'aws-sdk'

# AWS.config()

desc "Deletes a group of s3 File - rake delete_objects [bucket_name,path_with_trailing_slash,object1,object2...] - No Spaces betweena args!!"
task :delete_objects, [:bucket_name,:path] do |task,args|
  # s3_client = AWS::S3::Client.new(access_key_id: ENV['AWS_ACCESS_KEY_ID'], secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'])
  s3_client = AWS::S3::Client.new
  
  objects = []
  
  args.extras.each do |object_key|
    objects << {key: args[:path] + object_key}
  end
  
  puts objects.inspect
    
  result = s3_client.delete_objects({
    bucket_name: args[:bucket_name],
    objects: objects
  })
  
  puts result
end
