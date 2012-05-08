require "spec_helper"

describe PermissionForFoldersController do
  describe "routing" do

    it "routes to #index" do
      {:get => "/permission_for_folders"}.should_not be_routable
    end

    it "routes to #new" do
      {:get => "/permission_for_folders/new"}.should_not be_routable
    end

    it "routes to #show" do
      {:get => "/permission_for_folders/1"}.should_not be_routable
    end

    it "routes to #edit" do
      {:get => "/permission_for_folders/1/edit" }.should_not be_routable
    end

    it "routes to #create" do
      post("/permission_for_folders").should route_to("permission_for_folders#create")
    end

    it "routes to #update" do
      {:put => "/permission_for_folders/1"}.should_not be_routable
    end

    it "routes to #destroy" do
      delete("/permission_for_folders/1").should route_to("permission_for_folders#destroy", :id => "1")
    end

  end
end
