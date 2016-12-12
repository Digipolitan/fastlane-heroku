module Fastlane
  module Actions
    module SharedValues
    end

    class HerokuAppDeployAction < Action
      def self.run(params)
        name = params[:name]
        source_git_url = params[:source_git_url]
        if env_vars = params[:env_vars]
          env_cmd = ["heroku config:set"]
          env_vars.each do |key, value|
            env_cmd << "#{key}=#{value}"
          end
          env_cmd << "--app #{name}"
          Actions.sh(env_cmd.join(" "), log: false)
        end
        Actions.sh("heroku git:clone --app #{name}")
        Actions.sh("git -C #{name} pull #{source_git_url}")
        Actions.sh("git -C #{name} push")
        Actions.sh("rm -rf #{name}", log: false)
        end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Deploy your Heroku app"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :name,
                                       env_name: "HEROKU_APP_NAME",
                                       description: "The Heroku app name",
                                       optional: false),
          FastlaneCore::ConfigItem.new(key: :source_git_url,
                                       env_name: "HEROKU_APP_SOURCE_GIT_URL",
                                       description: "The source code to deploy on Heroku",
                                       optional: false),
          FastlaneCore::ConfigItem.new(key: :env_vars,
                                       env_name: "HEROKU_APP_ENV_VARS",
                                       description: "Map of env vars for your Heroku instance",
                                       is_string: false,
                                       optional: true)
        ]
      end

      def self.authors
        ["bbriatte", "vbalasubramaniam"]
      end

      def self.is_supported?(platform)
        true
      end

      def self.example_code
        [
          'heroku_app_deploy(
            name: "my_heroku_app",
            source_git_url: "https://github.com/fastlane/boarding"
          )',
          'heroku_app_deploy(
            name: "dg_heroku_app",
            source_git_url: "https://github.com/fastlane/boarding",
            env_vars: [
              "ITC_APP_ID" => XXXXX
              "ITC_PASSWORD" => XXXX,
              "ITC_TOKEN" => XXXX,
              "ITC_USER" => XXXX@XXX.XXX
            ]
          )'
        ]
      end

      def self.category
        :misc
      end
    end
  end
end
