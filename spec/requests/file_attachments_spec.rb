require 'spec_helper'

describe "FileAttachments" do
  describe "GET /file_attachments" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get file_attachments_path
      response.status.should be(200)
    end
  end
end
