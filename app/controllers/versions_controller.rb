class VersionsController < ApplicationController

# region: API Versioning
    
    # update the current version of the API (prompting the Server to Update when it "gets" the latest API Version)
    def update_api_version
        # create a new API Version object with a unique name and version number
    end

    # get the current version of the API serviced (to check if the server needs to update)
    def get_api_version
        # get the API Version with the latest datetime (created_at)
    end

# endregion


# region: Client Versioning
    
    # Update the latest version of the Client (prompting the user to Update from the App Store)
    def update_client_version
    end

# endregion

private

    def update_api_version_params
        params.require(:api_version).permit(:version_number, :version_name)
    end


    def update_client_version_parms
        params.requre(:client_version).permit(:version_number, :version_name)
    end

end
