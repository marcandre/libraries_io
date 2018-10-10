class LibrariesIO::API < TLAW::API
  define do
    desc 'API for [Libraries.io](https://libraries.io/)'

    docs 'https://libraries.io/api'

    base 'https://libraries.io/api'

    param :api_key,
          default: -> { LibrariesIO.api_key },
          desc: 'get your api key from your account page: https://libraries.io/account'
    global :page, desc: 'page (default 1)'
    global :per_page, desc: 'results per page (default is `30`, max is `100`)'

    endpoint :platforms do
      desc "Get a list of supported package managers"
      docs "https://libraries.io/api#platforms"
    end

    namespace :platform, '/{platform_id}' do
      namespace :project, '/{id}' do
        endpoint :info, '' do
          desc "Get information about a package and it's versions"
        end

        endpoint :dependencies, '/{version}/dependencies' do
          param :version, default: 'latest', desc: 'Project version'
          desc "Get a list of dependencies for a version of a project"
        end

        endpoint :dependents do
          desc "Get packages that have at least one version that depends on a given project"
        end

        endpoint :dependent_repositories do
          desc "Get repositories that depend on a given project"
        end

        endpoint :contributors do
          desc "Get users that have contributed to a given project"
        end

        endpoint :sourcerank do
          desc "Get breakdown of SourceRank score for a given project"
        end

        endpoint :usage do
          desc "Get breakdown of version usage for a given project"
        end
      end
    end

    endpoint :search do
      desc 'Search for projects'
      docs 'https://libraries.io/api#project-search' # only exception to our generic scheme, see doc.rb
      param :q, keyword: false, required: true
      param :sort, enum: %i[rank stars dependents_count dependent_repos_count latest_release_published_at contributions_count created_at]
      param :languages
      param :licenses
      param :keywords
      param :platforms
    end

    namespace :repository, '/{host}/{owner}/{name}' do
      param :host, default: 'github', keyword: true
      param :owner, required: true, keyword: true
      param :name, required: true, keyword: true

      endpoint :info, '' do
        desc 'Get a info for a repository. Currently only works for open source repositories'
      end

      endpoint :dependencies do
        desc 'Get a list of dependencies for a repositories. Currently only works for open source repositories'
      end

      endpoint :projects do
        desc 'Get a list of packages referencing the given repository'
      end
    end

    namespace :user, '/{host}/{name}' do
      param :name, required: true, keyword: false
      param :host, default: 'github', keyword: true

      endpoint :info, '' do
        desc 'Get information for a given user or organization.'
      end

      endpoint :repositories do
        desc 'Get repositories owned by a user.'
      end

      endpoint :projects do
        desc "Get a list of packages referencing the given user's repositories."
      end

      endpoint :repository_contributions, '/repository-contributions' do
        desc "Get a list of repositories that the given user has contributed to."
      end

      endpoint :dependencies do
        param :platform, keyword: true, required: false
        desc "Get a list of repositories that the given user has contributed to."
      end
    end
  end
end
