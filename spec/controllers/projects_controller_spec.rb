require 'spec_helper'

describe ProjectsController do
  describe "create project," do
    let(:member){ create :user }
    before do
      session[:userid] = member.id
      post :create, project:{title:'Final Fantasy'}
    end

    subject{ Project.last }
    its(:first_page){ should be_nil }
    its(:last_page){ should be_nil }
  end
end
