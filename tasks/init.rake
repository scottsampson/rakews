require 'active_support/inflector'


namespace 'clients' do
  desc "Lists current clients"
  task :list do |task,args|
    Dir.glob('clients/*').each {|r| puts r}
  end
  
  desc "Create a client"
  task :create, [:name,:key,:secret,:region] do |task,args|
    name = args[:name]
    key = args[:key]
    secret = args[:secret]
    region = args[:region] || "us-east-1"
    
    # filename = name
    content = <<-EOS
export AWS_ACCESS_KEY_ID="#{key}"
export AWS_SECRET_ACCESS_KEY="#{secret}"

export AWS_REGION='#{region}'
EOS
    
    filename = "clients/" + ActiveSupport::Inflector.parameterize(name)
    
    File.open(filename, 'w') do |f2|  
      # use "\n" for two lines of text  
      f2.puts content
    end
    # s3_client = AWS::S3::Client.new()
    #       args.each do |arg|
    #     
    #       end 
  end
  
  desc "Create a client"
  task :source, :name do |task,args|
    name = args[:name]
    
    filename = "clients/" + ActiveSupport::Inflector.parameterize(name)
    
    puts "Fooled you! -- Just run \"source #{filename}\""
  end
end