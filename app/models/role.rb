class Role < ActiveRecord::Base
  #has_many :user

  def find_by_name(role)
    logger.info role
    #self.where(:zombie => "ash")
  end
end
