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
end
