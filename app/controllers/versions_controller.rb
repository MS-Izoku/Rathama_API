class VersionsController < ApplicationController

    def create_api_version
    end

    def create_api_feature
    end

    def create_api_patch
    end



    def create_client_version
    end

    def create_client_feature
    end

    def create_client_patch
    end

private

    def update_api_version_params
        params.require(:api_version).permit(:version_name)
    end


    def update_client_version_parms
        params.require(:client_version).permit(:version_name)
    end

end
