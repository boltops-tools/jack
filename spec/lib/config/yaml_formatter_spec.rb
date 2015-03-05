require 'spec_helper'

describe Jack::Config::YamlFormatter do
  let(:sorter) { Jack::Config::YamlFormatter.new }

  describe "sorter" do
    it "process should sort the keys" do
      input = <<-EOL
EnvironmentConfigurationMetadata: 
  Description: test.
  Foo: 1
AWSConfigurationTemplateVersion: 1.1.0.0
EOL
      file = "spec/fixtures/fake.cfg.yml"

      File.open(file, 'w') { |file| file.write(input) }
      sorter.process(file)
      output = File.read(file)

      expect(output).to eq <<-EOL
AWSConfigurationTemplateVersion: 1.1.0.0
EnvironmentConfigurationMetadata: 
  Description: test.
  Foo: 1
EOL
    end

    it "process should strip date modified and created" do
      input = <<-EOL
EnvironmentConfigurationMetadata: 
  DateModified: '1425215243000'
  Description: test.
  DateCreated: '1425215243000'
AWSConfigurationTemplateVersion: 1.1.0.0
EOL
      file = "spec/fixtures/fake.cfg.yml"

      File.open(file, 'w') { |file| file.write(input) }
      sorter.process(file)
      output = File.read(file)

      expect(output).to eq <<-EOL
AWSConfigurationTemplateVersion: 1.1.0.0
EnvironmentConfigurationMetadata: 
  Description: test.
EOL
    end
  end
end