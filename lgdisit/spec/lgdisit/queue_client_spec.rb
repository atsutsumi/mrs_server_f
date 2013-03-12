require "spec_helper"

describe Lgdisit::QueueClient do
	let(:mode) { double("mode") }
	let(:sender) { double("sender") }
	let(:file_format) { double("file_format") }
	let(:client) { Lgdisit::QueueClient.new(mode, sender, file_format) }

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

	describe "#add_header" do
		context "the data is nil" do
			it "raises a NilError" do
				expect { client.add_header(nil) }.to raise_error(Lgdisit::NilError)
			end
		end

		context "the data is not nil" do
			let(:data) { double("data") }

			it "does not raise any error" do
				expect { client.add_header(data)}.to_not raise_error
			end
		end
	end
end
