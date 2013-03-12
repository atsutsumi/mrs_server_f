require "spec_helper"

describe Lgdisit::Net::MailMessage do
	let(:to_mail_address) { [double("to_mail_address1"),double("to_mail_address2")] }
	let(:from_mail_address) { double("from_mail_address") }
	let(:mail_subject) { double("subject") }
	let(:mail_body) { double("body") }

	context "creating an instance" do
		context "'from' address is nil" do
			it "raises NilError" do
				expect { Lgdisit::Net::MailMessage.new(nil, to_mail_address)}.to raise_error(Lgdisit::NilError)
			end
		end

		context "'to' address is nil" do
			it "raises NilError" do
				expect { Lgdisit::Net::MailMessage.new(from_mail_address, nil)}.to raise_error(Lgdisit::NilError)
			end
		end

		context "'to' address is not an array" do
			it "raises ArgumentError" do
				email_address = double("email_address")
				expect { Lgdisit::Net::MailMessage.new(from_mail_address, email_address)}.to raise_error(Lgdisit::ArgumentError)
			end
		end

		context "'to' address is an empty array" do
			it "raises ArgumentError" do
				expect { Lgdisit::Net::MailMessage.new(from_mail_address, [])}.to raise_error(Lgdisit::ArgumentError)
			end
		end

		context "'to' address and 'from' address are not nil" do
			it "does not raise any error" do
				expect { Lgdisit::Net::MailMessage.new(from_mail_address, to_mail_address)}.to_not raise_error(Lgdisit::NilError)
			end
		end
	end

	context "each properties" do
		let(:mail_message) { Lgdisit::Net::MailMessage.new(from_mail_address, to_mail_address, mail_subject, mail_body) }

		context "message:to" do
			subject { mail_message.to }
			it "should equal to 'to' mail address" do
				should eq to_mail_address
			end
		end

		context "message:from" do
			subject { mail_message.from }
			it "should equal to 'from' mail address" do
				should eq from_mail_address
			end
		end

		context "message:subject" do
			subject { mail_message.subject }
			it "should equal to mail subject" do
				should eq mail_subject
			end
		end

		context "message:body" do
			subject { mail_message.body }
			it "should equal to mail body" do
				should eq mail_body 
			end
		end
	end
end
