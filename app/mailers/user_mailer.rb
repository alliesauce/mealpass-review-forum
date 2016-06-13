class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def welcome(user)
    @user = user
    mail to: user.email, subject: "Welcome to Mealpass Reviews"
  end

  def account_activation(user)
    @user = user
    mail to: user.email, subject: "Mealpass Reviews - Account Activation"
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Mealpass Reviews - Password Reset"
  end

end
