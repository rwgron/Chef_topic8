# Recipe download, unpack and put application jar to Jboss deploy folder. Then restart Jboss.

# Install unzip 

package "unzip" do
   action :install
end

jboss_home = node['jboss']['jboss_home']
  remote_file "/tmp/hudson.zip" do
  source "http://www.cumulogic.com/download/Apps/hudson.zip"
end
execute "unzip_app" do
  cwd "/tmp/"
  command "unzip hudson.zip -d #{jboss_home}/standalone/deployments/"
  not_if {::File.exists?("#{jboss_home}/standalone/deployments/hudson")}
  action :run
end
  service "jboss" do
  action [:start]
end
