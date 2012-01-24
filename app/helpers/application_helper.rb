module ApplicationHelper
  
  def admins_only(&block)
    block.call if current_user.try(:admin?)
  end

  def authorized?(permission, thing, &block)
    block.call if current_user.try(:admin?) || can?(permission.to_sym, thing) 
  end

end
