class ExpansionsController < ApplicationController

    def index
        @expansions = Expansion.all.to_a

        if Rails.cache.exist?("expansions")
            @expansions = Rails.cache.read("expansions")
        else
            @expansions = Expansion.all.to_a
            Rails.cache.write("expansions", @expansions, expires_in: 12.hours)
        end
        render json: ExpansionSerializer.many(@expansions)
    end

    
    def show
        @expansion = Expansion.find_by(id: params[:id])
        return render json: { error: 'Expansion not found' }, status: :not_found unless @expansion
      
        key = "expansion_#{@expansion.id}"
      
        if Rails.cache.exist?(key)
          @expansion = Rails.cache.read(key)
        else
          Rails.cache.write(key, @expansion, expires_in: 12.hours)
        end
      
        render json: ExpansionSerializer.new(@expansion).serializable_hash
      end

end