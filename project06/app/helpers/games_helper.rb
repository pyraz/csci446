module GamesHelper

  def gamez_header
    controller = params[:controller]
    unless controller == 'games'
      render 'games/header', :controller => controller
    end
  end

  def member_gamez_header
    raw RedCloth.new("h2. My Gamez").to_html + new_game
  end

  def admin_gamez_header
    count = Game.count
    raw RedCloth.new("h2. #{pluralize(count, "Total Game")}").to_html + new_game
  end

  def game_title(game)
    if current_user.nil?
      game.title
    elsif current_user.is_admin?
      link_to game.title, edit_admin_game_path(game)
    else
      if game.created_by? current_user
        link_to game.title, edit_members_game_path(game)
      else
        game.title
      end
    end
  end

  def game_rating(game)
    if game.rating.blank?
      "Unrated"
    else
      game.rating.title
    end
  end

  def new_game
    if current_user.nil?
      return
    elsif current_user.is_admin?
      link_to image_tag('add.png') + "Add a game", new_admin_game_path,
        :class => 'button'
    else
      link_to image_tag('add.png') + "Add a game", new_members_game_path,
        :class => 'button'
    end
  end

  def created_at_and_by(game)
    if game.user == current_user
      name = "me"
    else
      name = game.user.full_name
    end

    "#{game.created_at.strftime("%b. %-d, %Y")} by #{name}"
  end

  def stats
    unless current_user.nil?
      "I've created #{pluralize(current_user.games_count, "game")}, " +
        "#{current_user.percent_of_games_rated}% of which are rated." 
    end
  end

  def creator(f)
    unless current_user.nil? || params[:action] == 'new'
      render('games/creator', :form => f) if current_user.is_admin?
    end
  end

end