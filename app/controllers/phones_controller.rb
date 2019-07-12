class PhonesController < ApplicationController
  before_action :set_contatct
  # GET /contacts/:contact_id/phones
  # GET /contacts/:contact_id/relationships/phones
  def show
    render json: @contact.phones
  end

  # POST /contacts/:contact_id/phone
  def create
    @contact.phones << Phone.new(phone_params)

    if @contact.save
      render json: @contact.phones, status: :created, location: contact_phones_url(@contact)
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  # PUT /contacts/:contact_id/phone
  # PATCH /contacts/:contact_id/phone
  def update
    phone = Phone.find(phone_params[:id])
    
    if phone.update(phone_params) 
      render json: @contact.phones
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end
  
  # DELETE /contacts/:contact_id/phone
  def destroy
    phone = Phone.find(phone_params[:id])
    phone.destroy
  end

  private

  def set_contatct
    @contact = Contact.find(params[:contact_id])
  end

  def phone_params
    ActiveModelSerializers::Deserialization.json_parse(params)
  end
end