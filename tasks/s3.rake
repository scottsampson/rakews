require 'aws-sdk'

# AWS.config()

desc "Deletes a group of s3 File - rake delete_objects [bucket_name,path_with_trailing_slash,object1,object2...] - No Spaces betweena args!!"
task :delete_objects, [:bucket_name,:path] do |task,args|
  s3_client = AWS::S3::Client.new
  
  objects = []
  
  args.extras.each do |object_key|
    objects << {key: args[:path] + object_key}
  end
  
  # puts objects.inspect
    
  result = s3_client.delete_objects({
    bucket_name: args[:bucket_name],
    objects: objects
  })
  
  puts result.inspect
end

desc "Lists the buckets for an s3 account"
task :list_buckets do |task,args|
  s3_client = AWS::S3::Client.new
  
  # objects = []
  # 
  # args.extras.each do |object_key|
  #   objects << {key: args[:path] + object_key}
  # end
  
  # puts objects.inspect
    
  result = s3_client.list_buckets({})
  
  puts result
end

desc "Lists a group of s3 Files - rake list_objects [bucket_name*,delimiter,marker,max_keys,prefix] - http://docs.aws.amazon.com/AWSSDKforPHP/latest/index.html#m=AmazonS3/list_objects"
task :list_objects, [:bucket_name,:delimiter,:marker,:max_keys,:prefix] do |task,args|
  s3_client = AWS::S3::Client.new
      
  result = s3_client.list_objects({
    bucket_name: args[:bucket_name],
    delimiter: args[:delimiter],
    marker: args[:marker],
    max_keys: args[:max_keys],
    prefix: args[:prefix]
  })
  
  result[:contents].map{|obj| puts obj.inspect + "\n\n"}
end


desc "Deletes a group of s3 File - path example 'pdf/'"
task :search_objects, [:bucket_name,:path,:str] do |task,args|
  s3_client = AWS::S3::Client.new
    
  result = s3_client.list_objects({
    bucket_name: args[:bucket_name],
    prefix: args[:path] + args[:str]
  })
  
  result[:contents].map{|obj| puts obj[:key] + "\n"}
end


