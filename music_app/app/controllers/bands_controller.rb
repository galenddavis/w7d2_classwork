class BandsController < ApplicationController

    def index
        @bands = Band.all 
        render :index
    end

    def new
        @band = Band.new
        render :new
    end

    def create
        @band = Band.new(band_params)
        if @band.save
            redirect_to bands_url(@band)
        else
            flash.now[:error] = @band.errors.full_messages
            render :new
        end
    end
     
    def edit

    end

    def show
        @band = Band.find_by(params[:id])
        render :show
    end

    def update
        
    end

    def destroy
        @band = Band.find_by(params[:id])
        @band.destroy
        redirect_to band_url(@band)
    end

    private

    def band_params
        params.require(:band).permit(:name)
    end
end
