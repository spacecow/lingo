require 'spec_helper'

describe Page do
  #--------- VALIDATIONS -------------------
  it 'pos cannot be blank' do
    expect{ create :page, pos:nil }.to raise_error *blank_error
  end
  it 'pos can be duplicated over other projects' do
    create :page, pos:1
    expect{ create :page, pos:1 }.to_not raise_error
  end

  #------- pos related functions ------------
  describe "set_pos" do
    it "pos is set to the number of pages in the project+1" do
      project = create :project
      create :page, pos:1, project_id:project.id
      second_page = build :page, project_id:project.id 
      second_page.set_pos
      second_page.pos.should eq 2
    end
  end

  describe "decrease_pos" do
    it "page decreases with 1" do
      page = create :page, pos:0
      page.decrease_pos
      page.pos.should eq -1
    end
  end

  describe "increase_pos" do
    it "page increases with one" do
      page = create :page, pos:100
      page.increase_pos
      page.pos.should eq 101
    end
  end

  describe "next_page," do
    let(:page){ create :page, pos:1 }
    context "there is no next page" do
      it "returns nil" do
        page.next_page.should be_nil 
      end
    end

    context "there is a next page," do
      let!(:next_page){ create :page, pos:4, project_id:page.project_id }

      it "returns that page" do
        page.next_page.should eq next_page 
      end
    end 
  end

  describe "prev_page," do
    let(:page){ create :page, pos:1 }
    context "there is no previous page" do
      it "returns nil" do
        page.prev_page.should be_nil 
      end
    end

    context "there is a previous page," do
      let!(:prev_page){ create :page, pos:0, project_id:page.project_id }

      it "returns that page" do
        page.prev_page.should eq prev_page
      end
    end 
  end
end
