require_relative 'spec_helper'

RSpec.describe LibrariesIO, vcr: {record: :new_episodes} do
  let(:api) { LibrariesIO.new }

  subject { api }

  its(:platforms) { should include(hash_including(
    'project_count', 'color',
    'name' => 'Rubygems',
    'homepage' => 'https://rubygems.org',
    'default_language' => 'Ruby',
  ))}

  describe 'for a given project' do
    let(:project_name) { 'deep-cover' }
    let(:project) { api.rubygems.project(project_name) }
    subject { project }

    its(:info) { should match(hash_including(
      'name', 'platform', 'description', 'stars', # ...
      'repository_url'=>'https://github.com/deep-cover/deep-cover',
    ))}

    it('can return dependencies') {
      result = project.dependencies
      result.should match(hash_including('repository_url'=>'https://github.com/deep-cover/deep-cover'))
      dependencies = result['dependencies'];
      dependencies.should include hash_including({
        'kind' => 'runtime',
        'name' => 'deep-cover-core',
      })
      dependencies.should include hash_including({
        'kind' => 'Development',
        'name' => 'rubocop',
      })
    }

    its(:dependents) {
      should include(hash_including(
        'name' => 'activerecord_where_assoc',
        'homepage' => 'https://github.com/MaxLap/activerecord_where_assoc',
      ))
    }

    its(:dependent_repositories) {
      should include(hash_including(
        'full_name' => 'ScottHaney/file_data',
        'github_id' => '81630146',
      ))
    }

    its(:contributors) {
      should include(hash_including(
        'location', 'github_id',
        'login' => 'MaxLap',
        'name' => 'Maxime Lapointe',
      ))
    }

    describe 'when restricted to a specify number' do
      subject { project.contributors(per_page: 1) }

      its(:size) { should == 1 }
      it { should include hash_including(
        'location', 'github_id', 'login', 'name'
      )}
    end


    its(:sourcerank) {
      should match(hash_including(
        'basic_info_present' => 1,
        'license_present' => 1,
      ))
    }

    it('returns usage number') {
      result = project.usage
      result['>= 0'].should > 0
    }

  end

  it 'allows searching' do
    results = api.search('deep-cover', sort: :stars, platforms: 'Rubygems')
    results.should include(hash_including(
      'name' => 'deep-cover-core',
      'package_manager_url' => 'https://rubygems.org/gems/deep-cover-core',
    ))
  end

  describe 'for a given repository' do
    let(:owner) { 'MaxLap' }
    let(:name) { 'activerecord_where_assoc' }
    let(:repository) { api.repository({owner: owner, name: name}) }
    subject { repository }

    its(:info) { should match(hash_including(
        'full_name' => 'MaxLap/activerecord_where_assoc',
        'has_readme' => 'README.md',
    ))}

    it 'gives a list of dependencies' do
      result = repository.dependencies
      result['dependencies'].should include(hash_including(
        'latest', 'platform', 'requirements', # ...
        'name' => 'rubocop',
        'filepath' => 'activerecord_where_assoc.gemspec',
        'kind' => 'development',
      ))
    end

    describe 'for a repo with multiple subprojects' do
      let(:owner) { 'deep-cover' }
      let(:name) { 'deep-cover' }
      its(:projects) { should include(hash_including(
          'rank', 'stars', 'keywords',
          'name' => 'deep-cover',
        ))
        should include(hash_including(
          'name' => 'deep-cover-core',
        ))
      }
    end

  end

  describe 'for a given user' do
    let(:name) { 'marcandre' }
    let(:user) { api.user(name) }
    subject { user }

    its(:info) { should match(hash_including(
      'blog', 'company', 'created_at', 'email', 'followers',
      'user_type' => 'User',
      'name' => 'Marc-André Lafortune',
      'location' => 'Montreal, Canada',
      'github_id' => '33770',
    ))}

    its(:repositories) do
      should include(hash_including(
        'forks_count', 'default_branch', 'open_issues_count', 'stargazers_count',
        'full_name' => 'marcandre/backports',
        'language' => 'Ruby',
        'has_license' => 'LICENSE.txt',
      ))
    end

    its(:projects) do
      should include(hash_including(
        'dependent_repos_count', 'dependents_count', 'versions', 'latest_release_number', 'rank', 'stars', 'keywords',
        'name' => 'backports',
      ))
    end

    its(:repository_contributions) do
      should include(hash_including(
        'contributions_count', 'description', 'keywords', 'stargazers_count', 'open_issues_count',
        'full_name' => 'rails/rails',
        'has_license' => 'MIT-LICENSE',
      ))
    end

    its(:dependencies) do
      should include(hash_including(
        'dependent_repos_count', 'dependents_count', 'versions', 'latest_release_number', 'rank', 'stars', 'keywords',
        'name' => 'rspec',
      ))
    end

    it 'can return dependencies for a specific platform' do
      result = user.dependencies(platform: 'NPM')
      result.should include(hash_including(
        'name' => 'jQuery',
      ))
      result.should_not include(hash_including(
        'name' => 'rspec',
      ))
    end

  end

end
