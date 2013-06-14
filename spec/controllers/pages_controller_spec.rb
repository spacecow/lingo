require 'spec_helper'

describe PagesController do
  let(:project){ create :project }

  describe "create page," do
    let(:member){ create :user }
    before{ session[:userid] = member.id }

    context "project is empty of pages" do
      before{ post :create, project_id:project.id, page:{no:1} }
      let(:created_page){ Page.last }

      describe 'created page' do
        subject{ created_page }
        its(:prev){ should be_nil }
        its(:next){ should be_nil }
      end

      describe 'associated project' do
        subject{ Project.last }
        its(:first_page){ should eq created_page }
        its(:last_page){ should eq created_page }
      end
    end

    context "project has one page" do
      before do
        post :create, project_id:project.id, page:{no:1}
        post :create, project_id:project.id, page:{no:2}
      end
      let(:first_page){ Page.first }
      let(:last_page){ Page.last }

      describe 'first page' do
        subject{ first_page }
        its(:prev){ should be_nil }
        its(:next){ should eq last_page }
      end
      describe 'last page' do
        subject{ last_page }
        its(:prev){ should eq first_page }
        its(:next){ should be_nil }
      end
      it "why cant i use update?!?!?!?"

      describe 'associated project' do
        subject{ Project.last }
        its(:first_page){ should eq first_page }
        its(:last_page){ should eq last_page }
      end
    end

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
