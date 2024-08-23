class PasswordsController < Devise::PasswordsController
  # Override Devise's update action to set the status after password is reset
  def update
    super do |resource|
      if resource.errors.empty?
        resource.update(status: true) if resource.status == false
      end
    end
  end
end
