require 'spec_helper'

describe PosController do
  let(:project){ mock_model Project }
  before{ request.env["HTTP_REFERER"] = project_path(project) }

  describe "decrease" do
    let(:project){ create :project }
    let(:page){ create :page, pos:1, project_id:project.id }

    context "no page in the project immediately before" do
      it "page decreases with 1" do
        put :decrease, page_id:page.id
        Page.last.pos.should eq 0
      end
    end

    context "a page in the project immediately before" do
      it "pages switches pos" do
        page_before = create :page, pos:0, project_id:project.id
        put :decrease, page_id:page.id
        Page.find(page.id).pos.should eq 0 
        Page.find(page_before.id).pos.should eq 1
      end
    end
  end 

  describe "increase", focus:true do
    let(:project){ create :project }

    context "project is empty" do
    end

    context "no page after" do
      let(:page){ create :page, pos:100, project_id:project.id }
      it "page increases with 1" do
        put :increase, page_id:page.id
        Page.last.pos.should eq 101
      end
    end  

    context "a page after" do
      let(:page){ create :page, id:1, pos:100, project_id:project.id, next_id:2 }
      let!(:page_after){ create :page, id:2, pos:101, project_id:project.id, prev_id:1 }

      it "pages switches pos" do
        put :increase, page_id:page.id
        Page.find(page.id).pos.should eq 101
        Page.find(page_after.id).pos.should eq 100
      end

      it "" do
        put :increase, page_id:page.id
        p Page.all
      end
    end
  end 
end
