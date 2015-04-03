require 'spec_helper'

describe ExtractingId do
	it 'has a version number' do
		expect(ExtractingId::VERSION).not_to be nil
	end

	context :Core do
		before {
			@testFile = "file/TestStoryboard.storyboard"
			@user = ExtractingId::Core.new
		}
		context :fileRead do
			before do
				@fileRead = @user.fileRead(@testFile)
			end
			it :count do
				expect(@fileRead.count).to eq 142
			end
			it "t1" do
				str = @user.exchange(@fileRead)
				expect(str).to eq [
					ExtractingId::Storyboard.new("HogeMoge"),
					ExtractingId::Restore.new("Cell"),
					ExtractingId::Segue.new("Edit"),
					ExtractingId::Segue.new("Back"),
				]
			end
		end
	end
end
