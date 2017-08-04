class ContactsController < ApplicationController
  
  #GET request to /contact-us
  #Show new contact form
  def new
    @contact = Contact.new
  end
  #Post request /contacts
  def create
    #Mass assignment of form fields into contact object
  @contact = Contact.new(contact_params)
  #save contact object ot the data base
    if @contact.save
      #store form fields via paramaters, into variables
      name = params[:contact][:name]
      email = params[:contact][:email]
      body = params[:contact][:comments]
      #Plug variables into the contact mailer email method and send email
      ContactMailer.contact_email(name, email, body).deliver
      #Store success messaage in flash has
      #and redirect to the new action.
      flash[:success] = "Message sent."
       redirect_to new_contact_path
    else
      #if contact object doesn't save,
      #store errors in flash hash, 
      #and redirect to the new action.
      flash[:danger] = @contact.errors.full_messages.join(", ")
      redirect_to new_contact_path
    end
  end
  
  private
  #To collect data from form, we need to use 
  #strong parameters and whitelist the form fields
  def contact_params
     params.require(:contact).permit(:name, :email, :comments)
  end
end
