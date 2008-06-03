require File.dirname(__FILE__) + '/../../spec_helper.rb'

describe Rugalytics::Profile do

  describe "being initialized" do

    it "should accept :name as key" do
      a = Rugalytics::Profile.new(:name => 'test', :profile_id => '12341234')
      a.name.should == 'test'
    end

    it "should accept :account_id as key" do
      a = Rugalytics::Profile.new(:account_id => '12341234', :profile_id => '12341234')
      a.account_id.should == '12341234'
    end

    it "should accept :profile_id as key" do
      a = Rugalytics::Profile.new(:profile_id => '12341234')
      a.profile_id.should == '12341234'
    end

  end

  describe "finding by account id and profile id" do
    it 'should find account and find profile' do
      account_id = 1254221
      profile_id = 12341234
      account = mock('account')
      profile = mock('profile')

      Rugalytics::Account.should_receive(:find).with(1254221).and_return account
      account.should_receive(:find_profile).with(profile_id).and_return profile
      Rugalytics::Profile.find(account_id, profile_id).should == profile
    end
  end

  it "should be able to find all profiles for an account" do
    html = fixture('analytics_profile_find_all.html')
    Rugalytics::Profile.should_receive(:get).and_return(html)
    accounts = Rugalytics::Profile.find_all('1254221')
    accounts.collect(&:name).should ==  ["blog.your_site.com"]
  end

  it "should be able to get pageviews" do
    profile = Rugalytics::Profile.new(:account_id => 344381, :profile_id => 543890)
    xml = fixture('dashboard_report_webgroup.xml')
    Rugalytics::Profile.should_receive(:get).and_return(xml)
    profile.pageviews.should == 283
  end

  it "should be able to get pageviews by day" do
    profile = Rugalytics::Profile.new(:account_id => 344381, :profile_id => 543890)
    xml = fixture('dashboard_report_webgroup.xml')
    Rugalytics::Profile.should_receive(:get).and_return(xml)
    dates = profile.pageviews_by_day
    dates.first.should == [Date.civil(2008, 2, 8), 72]
    dates.last.should == [Date.civil(2008, 3, 9), 0]
    dates.size.should == 31
  end

  it "should be able to get visits" do
    profile = Rugalytics::Profile.new(:account_id => 344381, :profile_id => 543890)
    xml = fixture('dashboard_report_webgroup.xml')
    Rugalytics::Profile.should_receive(:get).and_return(xml)
    profile.visits.should == 228
  end

  it "should be able to get visits by day" do
    profile = Rugalytics::Profile.new(:account_id => 344381, :profile_id => 543890)
    xml = fixture('dashboard_report_webgroup.xml')
    Rugalytics::Profile.should_receive(:get).and_return(xml)
    dates = profile.visits_by_day
    dates.first.should == [Date.civil(2008, 2, 8), 67]
    dates.last.should == [Date.civil(2008, 3, 9), 0]
    dates.size.should == 31
  end

  describe "finding by account name and profile name" do
    it 'should find account and find profile' do
      account_name = 'your_site.com'
      profile_name = 'blog.your_site.com'
      account = mock('account')
      profile = mock('profile')

      Rugalytics::Account.should_receive(:find).with(account_name).and_return account
      account.should_receive(:find_profile).with(profile_name).and_return profile
      Rugalytics::Profile.find(account_name, profile_name).should == profile
    end
  end

  describe "finding a profile by passing single name when account and profile name are the same" do
    it 'should find account and find profile' do
      name = 'your_site.com'
      account = mock('account')
      profile = mock('profile')

      Rugalytics::Account.should_receive(:find).with(name).and_return account
      account.should_receive(:find_profile).with(name).and_return profile
      Rugalytics::Profile.find(name).should == profile
    end
  end
end