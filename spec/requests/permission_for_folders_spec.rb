require 'spec_helper'

describe "PermissionForFolders" do
  describe "GET /permission_for_folders" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get permission_for_folders_path
      response.status.should be(200)
    end
  end
end
