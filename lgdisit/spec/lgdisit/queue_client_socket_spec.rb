require "spec_helper"

describe Lgdisit::QueueClientSocket do
	let(:mode) { double("mode") }
	let(:sender) { double("sender") }
	let(:file_format) { double("file_format") }
	let(:client) do
		config = mock(Hash)
		file_monitor_config = mock(Hash)

		Lgdisit.utility.should_receive(:get_yaml_config).and_return(config)
		config.should_receive(:[]).and_return(file_monitor_config)
		file_monitor_config.should_receive(:[]).and_return("/tmp/test.sock")

		Lgdisit::QueueClientSocket.new(mode, sender, file_format) 
	end

	context "creating an instance" do
		context "instance variable:mode" do
			subject { client.instance_variable_get(:@type_of_mode) }

			it "should be a specified parameter:mode" do
				should eq mode
			end
		end

		context "instance variable:sender" do
			subject { client.instance_variable_get(:@sender) }

			it "should be a specified parameter:sender" do
				should eq sender
			end
		end

		context "instance variable:file_format" do
			subject { client.instance_variable_get(:@file_format) }

			it "should be a specified parameter:file_format" do
				should eq file_format
			end
		end
	end

	describe "#enqueue?" do
	end
end
