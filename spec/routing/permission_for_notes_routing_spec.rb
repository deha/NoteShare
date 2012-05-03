require "spec_helper"

describe PermissionForNotesController do
  describe "routing" do

    it "routes to #index" do
      get("/permission_for_notes").should route_to("permission_for_notes#index")
    end

    it "routes to #new" do
      get("/permission_for_notes/new").should route_to("permission_for_notes#new")
    end

    it "routes to #show" do
      get("/permission_for_notes/1").should route_to("permission_for_notes#show", :id => "1")
    end

    it "routes to #edit" do
      get("/permission_for_notes/1/edit").should route_to("permission_for_notes#edit", :id => "1")
    end

    it "routes to #create" do
      post("/permission_for_notes").should route_to("permission_for_notes#create")
    end

    it "routes to #update" do
      put("/permission_for_notes/1").should route_to("permission_for_notes#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/permission_for_notes/1").should route_to("permission_for_notes#destroy", :id => "1")
    end

  end
end
