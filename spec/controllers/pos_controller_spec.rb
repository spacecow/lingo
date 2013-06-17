require 'spec_helper'

describe PosController do
  let(:project){ create :project }
  before{ request.env["HTTP_REFERER"] = project_path(project) }

  describe "decrease" do

    context "1 page," do
      let(:page){ create :page, project_id:project.id }
      before{ put :decrease, page_id:page.id }

      describe "page" do
        subject{ Page.find page.id }
        its(:prev){ should be_nil }
        its(:next){ should be_nil }
      end
    end  

    context "2 pages," do
      let(:project){ create :project, first_id:1, last_id:2 }
      let!(:page){ create :page, id:1, project_id:project.id, next_id:2 }
      let(:next_page){ create :page, id:2, project_id:project.id, prev_id:1 }
      before{ put :decrease, page_id:next_page.id }

      describe "first page" do
        subject{ Page.find next_page.id }
        its(:prev){ should be_nil }
        its(:next){ should eq page }
      end

      describe "second page" do
        subject{ Page.find page.id }
        its(:prev){ should eq next_page }
        its(:next){ should be_nil }
      end

      describe "project" do
        subject{ Project.first }
        its(:first_page){ should eq next_page }
        its(:last_page){ should eq page }
      end
    end

    context "4 pages," do
      let!(:page1){ create :page, id:1, project_id:project.id, next_id:2 }
      let!(:page2){ create :page, id:2, project_id:project.id, next_id:3, prev_id:1 }
      let!(:page3){ create :page, id:3, project_id:project.id, next_id:4, prev_id:2 }
      let!(:page4){ create :page, id:4, project_id:project.id, prev_id:3 }
      before{ put :decrease, page_id:page3.id }

      describe "first page" do
        subject{ Page.find page1.id }
        its(:prev){ should be_nil }
        its(:next){ should eq page3 }
      end

      describe "second page" do
        subject{ Page.find page3.id }
        its(:prev){ should eq page1 }
        its(:next){ should eq page2 }
      end

      describe "third page" do
        subject{ Page.find page2.id }
        its(:prev){ should eq page3 }
        its(:next){ should eq page4 }
      end

      describe "fourth page" do
        subject{ Page.find page4.id }
        its(:prev){ should eq page2 }
        its(:next){ should be_nil }
      end
    end
  end 

  describe "increase" do
    let(:project){ create :project }

    context "1 page," do
      let(:page){ create :page, project_id:project.id }
      before{ put :increase, page_id:page.id }

      describe "page" do
        subject{ Page.find page.id }
        its(:prev){ should be_nil }
        its(:next){ should be_nil }
      end
    end  

    context "2 pages," do
      let(:page){ create :page, id:1, project_id:project.id, next_id:2 }
      let!(:next_page){ create :page, id:2, project_id:project.id, prev_id:1 }
      before{ put :increase, page_id:page.id }

      describe "first page" do
        subject{ Page.find next_page.id }
        its(:prev){ should be_nil }
        its(:next){ should eq page }
      end

      describe "second page" do
        subject{ Page.find page.id }
        its(:prev){ should eq next_page }
        its(:next){ should be_nil }
      end
    end

    context "4 pages," do
      let!(:page1){ create :page, id:1, project_id:project.id, next_id:2 }
      let!(:page2){ create :page, id:2, project_id:project.id, next_id:3, prev_id:1 }
      let!(:page3){ create :page, id:3, project_id:project.id, next_id:4, prev_id:2 }
      let!(:page4){ create :page, id:4, project_id:project.id, prev_id:3 }
      before{ put :increase, page_id:page2.id }

      describe "first page" do
        subject{ Page.find page1.id }
        its(:prev){ should be_nil }
        its(:next){ should eq page3 }
      end

      describe "second page" do
        subject{ Page.find page3.id }
        its(:prev){ should eq page1 }
        its(:next){ should eq page2 }
      end

      describe "third page" do
        subject{ Page.find page2.id }
        its(:prev){ should eq page3 }
        its(:next){ should eq page4 }
      end

      describe "fourth page" do
        subject{ Page.find page4.id }
        its(:prev){ should eq page2 }
        its(:next){ should be_nil }
      end
    end
  end 
end
