class VersionsController < ApplicationController

# validate api key to ensure versioning is done by someone authorized

    def get_latest_api_version
        @version = ApiVersion.latest
        render json: @version
    end

    def get_latest_client_version
        @version = ClientVersion.latest
        render json: @version
    end

# region: API Versioning
  def create_api_version
    @new_version = ApiVersion.create_version(api_version_params[:version_name])
    render json: @new_version
  end

  def create_api_feature
    @new_feature = ApiVersion.create_feature
    render json: @new_feature
  end

  def create_api_patch
    @new_feature = ApiVersion.create_patch
    render json: @new_feature
  end
# endregion


# region: Client Versioning

  def create_client_version
    @new_version = ClientVersion.create_version(client_version_params[:version_name])
    render json: @new_version
  end

  def create_client_feature
    @new_feature = ClientVersion.create_feature
    render json: @new_feature
  end

  def create_client_patch
    @new_feature = ClientVersion.create_patch
    render json: @new_feature
  end

# endregion

  private

  def api_version_params
    params.require(:api_version).permit(:version_name)
  end

  def client_version_params
    params.require(:client_version).permit(:version_name)
  end
end
