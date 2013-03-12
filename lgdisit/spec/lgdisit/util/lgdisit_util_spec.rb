require "spec_helper"

describe Lgdisit::LgdisitUtil do
	let(:base_directory) { MONITOR_BASE_DIR }
	let(:utility) { Lgdisit::LgdisitUtil.new(base_directory) }

	context "creating an instance" do
		subject { utility.instance_variable_get(:@base_directory) }

		it do
			should eq base_directory
		end
	end

	describe "#get_config_directory" do
		context "verify if the path is a directory" do
			subject { File.directory?(utility.get_config_directory) }

			it "should be a directory" do
				should eq true
			end
		end

		context "verify the directory name" do
			subject { utility.get_config_directory }

			it "should end with /config" do
				should match ".*/config$"
			end
		end
	end

	describe "#get_yaml_config" do
		context "the yaml config file is nil" do
			it "raises a NilError" do
				expect { utility.get_yaml_config(nil) }.to raise_error(Lgdisit::NilError)
			end
		end

		context "the yaml configuration file does not exist" do
			it "raises a FileNotFoundError" do
				file = double("file")
				File.should_receive(:exists?).with(file).and_return(false)
				expect { utility.get_yaml_config(file) }.to raise_error(Lgdisit::FileNotFoundError)
			end
		end
	end

	describe ".get_parent_directory" do
		context "the specified file exist" do
			let(:file) { double("file") }
			let(:file_path) { mock("file_path") }

			before do
				File.should_receive(:exists?).and_return(true)
			end

			it "does not raise any errors"do
				expect { Lgdisit::LgdisitUtil.get_parent_directory(file) }.to_not raise_error
			end
		end
		context "the specified file path is nil" do
			it "raises a NilError" do
				expect { Lgdisit::LgdisitUtil.get_parent_directory(nil) }.to raise_error(Lgdisit::NilError)
			end
		end

		context "the specified file path does not exist" do
			it "raises a FileNotFoundError" do
				file = double("file")
				File.should_receive(:exists?).with(file).and_return(false)
				expect { Lgdisit::LgdisitUtil.get_parent_directory(file) }.to raise_error(Lgdisit::FileNotFoundError)
			end
		end
	end

	describe ".get_bracketed_string" do
		context "the string is a string" do
			it "does not raise any errors" do
				expect { Lgdisit::LgdisitUtil.get_bracketed_string("string") }.to_not raise_error
			end
		end

		context "the string is nil" do
			it "raises a NilError" do
				expect { Lgdisit::LgdisitUtil.get_bracketed_string(nil) }.to raise_error(Lgdisit::NilError)
			end
		end
	end
end
