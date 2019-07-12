class AddressesController < ApplicationController
  before_action :set_contatct
  # GET /contacts/:contact_id/address
  # GET /contacts/:contact_id/relationships/address
  def show
    render json: @contact.address
  end

  # POST /contacts/:contact_id/address
  def create
    @contact.address = Address.new(address_params)

    if @contact.save
      render json: @contact.address, status: :created, location: contact_address_url(@contact)
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  # PUT /contacts/:contact_id/address
  # PATCH /contacts/:contact_id/address
  def update
    if @contact.address.update(address_params)
      render json: @contact.address
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end
  
  # DELETE /contacts/:contact_id/address
  def destroy
    @contact.address.destroy
  end

  private

  def set_contatct
    @contact = Contact.find(params[:contact_id])
  end

  def address_params
    ActiveModelSerializers::Deserialization.json_parse(params)
  end
end