class ApartmentsController < ApplicationController

    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
    
    def index 
        render json: Apartment.all , status: :ok
    end

    def show
        apartment = find_apartment
        render json: apartment 
    end

    def create 
        apartment= Apartment.create!(apartment_pararms)
        render json: apartment, status: :created
    end

    def update
        apartment= find_apartment
        apartment.update!(apartment_params)
        render json: apartment, status: :updated
    end

    def destroy
        apartment= find_apartment
        apartment.destroy
        head :no_content
    end

    private

   def find_apartment
    apartment= Apartment.find(params[:id])
end

def apartment_pararms
    params.permit(:number)
end

def record_not_found
    render json: {error: "Not Found"}, status: :not_found
end

def record_invalid(invalid)
    render json: {error: invalid.record.errors.full_messages}, status: :unprocessable_entity
end

end
