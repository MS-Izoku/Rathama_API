# Manages the Version Numbering (ie: MAJOR.MINOR.PATCH)
# Contains 3 Major Functions:
# 1) create_major_increment     => Increment the Major Release Number (resets Minor and Patch)
# 2) create_minor_increment     => Increment the Minor Release Number (Resets Patch)
# 3) crrate_patch_number        => Increment the Patch Number (only effects Patch)
module VersionManager
  extend ActiveSupport::Concern

  included do
    puts "VersionManager included in #{name}"
    # This block runs when the module is included in a model
  end


  class_methods do

      # turn the hashed version into a string
      def stringify_version(version_hash)
        "#{version_hash[:major]}.#{version_hash[:minor]}.#{version_hash[:patch]}"
      end

    def latest
      order(created_at: :desc).first
    end

    def create_patch_number
      version = latest.parse_version
      version[:patch] += 1
      stringify_version(version)
    end

    def create_minor_increment
      version = latest.parse_version
      version[:minor] += 1
      version[:patch] = 0
      stringify_version(version)
    end




    def create_major_increment
      version = latest.parse_version

      version[:major] += 1
      version[:minor] = 0
      version[:patch] = 0

      stringify_version(version)
    end

  end


  def parse_version
    split_string = version_number.split('.').map(&:to_i)

    {
      major: split_string[0],
      minor: split_string[1],
      patch: split_string[2]
    }
  end

end
