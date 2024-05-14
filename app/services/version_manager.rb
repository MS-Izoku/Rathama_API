

# Manages the Version Numbering (ie: MAJOR.MINOR.PATCH)
# Contains 3 Major Functions:
# 1) create_major_increment     => Increment the Major Release Number (resets Minor and Patch)
# 2) create_minor_increment     => Increment the Minor Release Number (Resets Patch)
# 3) crrate_patch_number        => Increment the Patch Number (only effects Patch)
class VersionManager

# region: Version Numbering
    # Version Numbers are Formatted like so: MAJOR.MINOR.PATCH
    # Major: version increments when there are incompatible API changes (ie: Releases)
    # Minor: version increments when functionality is added in a backward-compatible manner (ie: Features)
    # Patch: version increments when backward-compatible bug fixes are made (ie: Bug Fixes)

    def self.create_patch_number(version_number_string)
        version = parse_version(version_number_string)
        version[:patch] += 1
        stringify_version(version)
    end

    def self.create_minor_increment(version_number_string)
        version = parse_version(version_number_string)
        version[:minor] += 1
        version[:patch] = 0
        stringify_version(version)
    end

    def self.create_major_increment(version_number_string)
        version = parse_version(version_number_string)
        
        version[:major] += 1
        version[:minor] = 0
        version[:patch] = 0
        
        stringify_version(version)
      end

private

    # turn the input version into a hash
    def self.parse_version(version_number_string)
        split_string = version_number_string.split('.').map(&:to_i)
        
        {
            major: split_string[0],
            minor: split_string[1],
            patch: split_string[2]
        }
    end

    # turn the hashed version into a string
    def self.stringify_version(version_hash)
        "#{version_hash[:major]}.#{version_hash[:minor]}.#{version_hash[:patch]}"
    end
# endregion
end