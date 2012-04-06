module UsersHelper

  def username_text_field(form)
    if current_user.nil?
      form.text_field :username
    elsif current_user.is_admin?
      form.text_field :username
    else
      form.text_field :username, :disabled => true
    end
  end

  def user_roles_li(form)
    unless current_user.nil? || !current_user.is_admin?
      render 'users/roles_li', :form => form
    end
  end

  def user_roles_select
    if current_user.nil?
      return
    elsif current_user.is_admin?
      select("roles", "id", Role.all.map { |r| [r.name, r.id] })
    else
      user_roles
    end
  end

  def user_roles
    current_user.role_symbols.compact.join(", ").to_s.humanize
  end

end
