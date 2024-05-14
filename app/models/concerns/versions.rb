
# a module that can be used to check the latest version of the application
# used in the Models:: APIVersion and ClientVersion
module LatestVersion
  extend ActiveSupport::Concern

  included do
    # This block runs when the module is included in a model
  end

  class_methods do
    def latest
      order(created_at: :desc).first
    end
  end
end
