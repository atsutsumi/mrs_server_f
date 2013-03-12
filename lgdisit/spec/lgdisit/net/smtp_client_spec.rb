require "spec_helper"

describe Lgdisit::Net::SmtpClient do
	let(:from_mail_address) { double("from_mail_address") }
	let(:to_mail_address1) { double("to_mail_address1") }
	let(:to_mail_address2) { double("to_mail_address2") }
	let(:mail_message) { Lgdisit::Net::MailMessage.new(from_mail_address,[to_mail_address1,to_mail_address2]) }
	let(:smtp_client){ Lgdisit::Net::SmtpClient.new }

	context "creating an instance" do
		context "port number is zero" do
			it "does not raise any error" do
				expect { Lgdisit::Net::SmtpClient.new("localhost", 0)}.to_not raise_error(Lgdisit::ArgumentOutOfRangeError)
			end
		end

		context "port number is larger than zero and less than 65536" do
			it "does not raise any error" do
				expect { Lgdisit::Net::SmtpClient.new("localhost", 65535)}.to_not raise_error(Lgdisit::ArgumentOutOfRangeError)
			end
		end

		context "port number is less than zero" do
			it "raises an ArgumentOutOfRangeError" do
				expect { Lgdisit::Net::SmtpClient.new("localhost", -1)}.to raise_error(Lgdisit::ArgumentOutOfRangeError)
			end
		end

		context "port number is larger than 65535" do
			it "raises an ArgumentOutOfRangeError" do
				expect { Lgdisit::Net::SmtpClient.new("localhost", 65536)}.to raise_error(Lgdisit::ArgumentOutOfRangeError)
			end
		end

	end

	describe "#create_message" do
		context "message is nil" do
			it "raises a NilError" do
				expect { smtp_client.create_message(nil) }.to raise_error(Lgdisit::NilError)
			end
		end

		context "message is a string" do
			it "raises an ArgumentError" do
				expect { smtp_client.create_message("string") }.to raise_error(Lgdisit::ArgumentError)
			end
		end

		context "message is an integer" do
			it "raises an ArgumentError" do
				expect { smtp_client.create_message(123) }.to raise_error(Lgdisit::ArgumentError)
			end
		end
	end

	describe "#send" do
		let(:smtp_client){ Lgdisit::Net::SmtpClient.new }

		context "a MailMessage is not nil" do

			before do
				from_mail_address.stub(:address).and_return("nanashi@noname.co.jp")
				from_mail_address.stub(:display_name).and_return("nanashi")
				to_mail_address1.stub(:address).and_return("jdoe@noname.com")
				to_mail_address1.stub(:display_name).and_return("john doe")
				to_mail_address2.stub(:address).and_return("jdoe@noname.com")
				to_mail_address2.stub(:display_name).and_return("jane doe")
			end

			it "does not raise any errors" do
				expect { smtp_client.create_message(mail_message) }.to_not raise_error
			end
		end

		context "a MailMessage is nil" do
			let(:mail_message) { nil }

			it "raises a NilError" do
				expect { smtp_client.send(mail_message) }.to raise_error(Lgdisit::NilError)
			end
		end
	end
end
