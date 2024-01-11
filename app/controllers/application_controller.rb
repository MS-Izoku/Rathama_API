class ApplicationController < ActionController::API
    def render_error(model_with_errors, message)
        { 
            error: { message: message },
            all_errors: model_with_errors.errors
        }
    end
end
