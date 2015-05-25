class ChargesController < ApplicationController

  def create
    #Amount in cents params[:stripeAmount].to_i * 100
    @amount = 10_00

    # Creates Stripe Customer object to associate with charge
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
      )
  
    charge = Stripe::Charge.create(
      customer: customer.id, # Not the same as user_id in app
      amount: @amount,
      description: "BigMoney Membership - #{current_user.email}",
      currency: 'usd'
      )

    flash[:success] = "Thanks for all the money, #{current_user.email}! Feel free to pay me again."
    redirect_to user_path(current_user)

    # Stripe handles the card errors, but this block catches and displays them
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path
    end
  end

  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "BigMoney Membership - #{current_user.name}",
      amount: @amount
    }
  end


