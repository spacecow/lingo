require 'spec_helper'

describe PagesController do
  let(:project){ create :project }

  describe "create," do
    let(:member){ create :user }
    before{ session[:userid] = member.id }

    context "pages in the project are not incrementaly inline," do
      it "pos is set to the number of pages in the project +1 or the next available spot" do
        create :page, pos:3, project_id:project.id
        create :page, pos:4, project_id:project.id
        post :create, project_id:project.id, page:{no:1}
        Page.last.pos.should eq 5
      end
    end
  end
end 
