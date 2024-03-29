require 'test_helper'

class Clients::RepoTest < ActiveSupport::TestCase

  test "Repo class exists" do
    assert Clients::Repo.new(response: {'url' => '', "name" => ''})
  end

  test "Repo class should start w/response json" do
    assert_raise(ArgumentError) { Clients::Repo.new }
    assert Clients::Repo.new(response: {'url' => '', "name" => ''})
  end

  test "Repo class contains URL to contents for that repo on github" do
    client = Clients::Github.new
    assert_equal client.repos.first.url, "#{client.repos.first.response.fetch('url')}/contents"
  end

  test "Repo class contains title to contents for repo on github" do
    client = Clients::Github.new
    assert_equal client.repos.first.title, "backend-languages"
  end

  test "Repo class fetches contents of repos in org via repo contents path" do
    repo = Clients::Github.new.repos.first
    assert_not_nil repo.contents
  end

  test "Repo class contains #.save method that allows it to save course data" do
    repo = Clients::Github.new.repos.first
    assert_predicate repo, :save
  end

  test "Repo class #.save! method raises an error message if saving fails" do
    Clients::Github.all.each do |repo|
      assert_nothing_raised { repo.save! }
    end
  end

  test "github client #.save method does NOT raise an error message if saving fails" do
    Clients::Github.all.each do |repo|
      assert_nothing_raised { repo.save! }
    end
  end

  test "github client saves repos as courses when building out the data models" do
    Clients::Github.all.each do |repo|
      assert repo.save!
      assert_equal Course.last.title, repo.title
    end
  end

end
