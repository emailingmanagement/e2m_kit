class AddUser < ActiveRecord::Migration
  def self.up
    User.create(
      :email => 'fdlambert@gmail.com', :password => 'azerty', :password_confirmation => 'azerty', :first_name => 'Frédéric',
      :last_name => 'de Lambert'
    )
  end

  def self.down
  end
end