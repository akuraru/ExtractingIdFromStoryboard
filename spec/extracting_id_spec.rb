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
				@str = @user.exchange(@fileRead)
			end
			it :count do
				expect(@fileRead.count).to eq 142
			end
			it "t1" do
				expect(@str).to eq [
					ExtractingId::Storyboard.new("HogeMoge"),
					ExtractingId::Restore.new("Cell"),
					ExtractingId::Segue.new("Edit"),
					ExtractingId::Segue.new("Back"),
				]
			end
			it :t2 do
				define = @str.map{|s| s.define}
				expect(define).to eq [
					"kStoryboardHogeMoge",
					"kRestoreCell",
					"kSegueEdit",
					"kSegueBack",
				]
			end
			it :t3 do
				define = @str.map{|s| s.impDefine}
				expect(define).to eq [
					"\#define kStoryboardHogeMoge @\"HogeMoge\"\n",
					"\#define kRestoreCell @\"Cell\"\n",
					"\#define kSegueEdit @\"Edit\"\n",
					"\#define kSegueBack @\"Back\"\n",
				]
			end
		end
	end
end
