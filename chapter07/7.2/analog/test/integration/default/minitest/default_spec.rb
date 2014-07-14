 require 'minitest/autorun'

describe 'Winning' do

  it "should exist" do
    assert File.exists?("/usr/bin/analog")
  end

  it "should be executable" do
    assert File.executable?("/usr/bin/analog")
  end

  it "should be right version" do
    assert system("/usr/bin/analog 2>/dev/null | grep 'analog 6.0' 1>/dev/null")
  end

end
