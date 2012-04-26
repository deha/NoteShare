require "spec_helper"

describe FileAttachmentsController do
  describe "routing" do

    it "routes to #index" do
      get("/file_attachments").should route_to("file_attachments#index")
    end

    it "routes to #new" do
      get("/file_attachments/new").should route_to("file_attachments#new")
    end

    it "routes to #show" do
      get("/file_attachments/1").should route_to("file_attachments#show", :id => "1")
    end

    it "routes to #edit" do
      get("/file_attachments/1/edit").should route_to("file_attachments#edit", :id => "1")
    end

    it "routes to #create" do
      post("/file_attachments").should route_to("file_attachments#create")
    end

    it "routes to #update" do
      put("/file_attachments/1").should route_to("file_attachments#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/file_attachments/1").should route_to("file_attachments#destroy", :id => "1")
    end

  end
end
