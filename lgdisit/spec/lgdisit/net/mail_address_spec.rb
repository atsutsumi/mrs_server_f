require "spec_helper"

describe Lgdisit::Net::MailAddress do
	context "creating an instance" do
		context "the email address is nil" do
			it "raises a NilError" do
				expect { Lgdisit::Net::MailAddress.new(nil)}.to raise_error(Lgdisit::NilError)
			end
		end

		context "the email address is empty" do
			it "raises an ArgumentError" do
				expect { Lgdisit::Net::MailAddress.new("")}.to raise_error(Lgdisit::ArgumentError)
			end
		end

		context "the email address is invalid" do
			it "raises a Format Error" do
				# assume that the email address is invalid
				Lgdisit::Net::MailAddress.stub(:valid?).and_return(false)
				expect { Lgdisit::Net::MailAddress.new("niceandsimple@example.com") }.to raise_error(Lgdisit::FormatError)
			end
		end
	end

	describe ".valid?" do
		context "the email address is valid" do
			context "username with domain" do
				subject { Lgdisit::Net::MailAddress.valid?("niceandsimple@example.com") }
				it "should be true" do
					should be_true
				end
			end

			context "dash in address field" do
				subject { Lgdisit::Net::MailAddress.valid?("nice-and-simple@example.com") }
				it "should be true" do
					should be_true
				end
			end

			context "digits in address field" do
				subject { Lgdisit::Net::MailAddress.valid?("1234567890@example.com") }
				it "should be true" do
					should be_true
				end
			end

			context "underscore in address field" do
				subject { Lgdisit::Net::MailAddress.valid?("__________@example.com") }
				it "should be true" do
					should be_true
				end
			end
		end

		context "the email address is invalid" do
			context "missing @ sign and domain" do
				subject { Lgdisit::Net::MailAddress.valid?("niceandsimpleexamplecom") }
				it "should be false" do
					should be_false
				end
			end

			context "missing username" do
				subject { Lgdisit::Net::MailAddress.valid?("@examplecom") }
				it "should be false" do
					should be_false
				end
			end

			context "top level domain(.com/.net/.org/etc) is missing" do
				subject { Lgdisit::Net::MailAddress.valid?("niceandsimple@example") }
				it "should be false" do
					should be_false
				end
			end

			context "two @ sign" do
				subject { Lgdisit::Net::MailAddress.valid?("nice@andsimple@examplecom") }
				it "should be false" do
					should be_false
				end
			end
		end
	end
end
