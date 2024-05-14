class VersionsController < ApplicationController

# validate api key to ensure versioning is done by someone authorized (for updating versions)

    def get_latest_api_version
        @version = ApiVersion.latest
        render json: @version
    end

    def get_latest_client_version
        @version = ClientVersion.latest
        render json: @version
    end

    def get_api_version_with_notes
        @version = ApiVersion.find_by(version_number: get_version_with_note_params[:version_number])
        if @version
            render json: { version: @version, notes: @version.release_notes }
        else
            render json: { error: "Version not found" }
        end
    end

    def get_client_version_with_notes
        @version = ClientVersion.find_by(version_number: get_version_with_note_params[:version_number])
        if @version
            render json: { version: @version, notes: @version.release_notes }
        else
            render json: { error: "Version not found" }
        end
    end


    def add_note
        @note = ReleaseNote.create(add_note_params)
        render json: @note
    end

    def update_note
        @note = ReleaseNote.find_by(id: update_note_params[:id])
        if @note
            @note.update(update_note_params[:text])
            render json: @release_note
        else
            render json: {error: "Release-Note not found with Id #{update_note_params[:id]}"}
        end
    end

    def delete_note
        @note = ReleaseNote.find_by(id: delete_note_params[:id])
        if @note
        @note.destroy
        render json: @note
        else
            render json: {error: "Release-Note with Id #{delete_note_params[:id]} not found"}
        end
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


  # Release Notes
  def add_note_params
    params.require(:release_note).permit(:version_id, :text)
  end

  def update_note_params
    params.require(:release_note).permit(:id, :text)
  end

  def delete_note_params
    params.require(:release_note).permit(:id)
  end

  # Get Version with Notes
  def get_version_with_note_params
    params.permit(:version_number)
  end
end
