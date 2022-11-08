class TenantsController < ApplicationController

    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

    def create
        lease = Lease.create!(lease_params)
        render json: lease, status: :created
    end

    def destroy  
        lease = Lease.find(params[:id])
        lease.destroy
        head :no_content
    end

private

    def lease_params 
        params.permit(:rent, :apartment_id, :tenant_id)
    end

    def record_not_found
        render json: {error: "Not Found"}, status: :not_found
    end

    def record_invalid(invalid)
        render json: {error: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end

end
 48  
app/controllers/tenants_controller.rb
@@ -0,0 +1,48 @@
class TenantsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

    def index
        render json: Tenant.all
    end

    def show
        tenant = find_tenant
        render json: tenant
    end

    def create
        tenant = Tenant.create!(tenant_params)
        render json: tenant, status: :created
    end

    def update
        tenant = find_tenant
        tenant.update!(tenant_params)
        render json: tenant, status: :accepted
    end

    def destroy
        find_tenant.destroy
        head :no_content
    end

    private

    def tenant_params 
        params.permit(:name, :age)
    end

    def find_tenant
        tenant = Tenant.find(params[:id])
    end

    def record_not_found
        render json: {error: "Not Found"}, status: :not_found
    end

    def record_invalid(invalid)
        render json: {error: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end
end
