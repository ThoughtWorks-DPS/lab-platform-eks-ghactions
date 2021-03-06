require 'awspec'
require 'json'

tfvars = JSON.parse(File.read('./' + ENV['TF_WORKSPACE'] + '.auto.tfvars.json'))

describe eks(tfvars["cluster_name"]) do
  it { should exist }
  it { should be_active }
  its(:version) { should eq tfvars['cluster_version'] }
end

describe iam_role(tfvars["cluster_name"] + '-cluster-autoscaler') do
  it { should exist }
end

describe iam_role(tfvars["cluster_name"] + '-cloudwatch-agent') do
  it { should exist }
end
