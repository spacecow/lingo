require 'spec_helper'

describe 'Pages new, layout' do
  before(:each) do
    signin
    @project = FactoryGirl.create(:project,title:'Ashita no Joe')
    visit new_project_page_path(@project)
  end

  it "has a title" do
    page.should have_title('New Page for Ashita no Joe')
  end

  it "has a new page form" do
    page.should have_form(:new_page)
  end

  it "has the no value set to blank" do
    value('* No').should be_nil
  end
  it "has the image value set to blank" do
    value('Image').should be_nil
  end

  it "has a create page button" do
    page.should have_submit_button('Create Page') 
  end
  it "has a cancel button" do
    page.should have_cancel_button
  end

  context "create" do
    before(:each) do
      fill_in 'No', with:2
    end

    it "saves project to db" do
      lambda do click_button 'Create Page'
      end.should change(Page,:count).by(1)
    end

    context "saves" do
      before(:each) do
        click_button 'Create Page'
        @page = Page.last
      end

      it "no" do
        @page.no.should be 2 
      end
      it "project_id" do
        @page.project_id.should be @project.id
      end

      it "shows a flash message" do
        page.should have_notice('Page created')
      end
      it "redirects to the project page" do
        current_path.should eq project_path(@project)
      end
    end

    context "saves image", image:true do
      before(:each) do
        attach_file 'Image', 'app/assets/images/devianart.jpg'
        click_button 'Create Page'
        @page = Page.last
      end

      it "as regular" do
        @page.image_url.should eq "/uploads/project/#{@project.id}/page/image/#{@page.id}/devianart.jpg"
      end
      it "as large" do
        @page.image_url(:large).should eq "/uploads/project/#{@project.id}/page/image/#{@page.id}/large_devianart.jpg"
      end
    end

    context "error" do
      it "no cannot be blank" do
        fill_in 'No', with:''
        click_button 'Create Page'
        div(:no).should have_blank_error  
      end
    end

    context "cancel" do
      it "directs back to the project page" do
        click_button 'Cancel'
        current_path.should eq project_path(@project)
      end
    end
  end
end
