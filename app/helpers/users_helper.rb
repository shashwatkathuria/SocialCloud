module UsersHelper
  def filterFollowDetailsForJson(users, following_list)
    @temp = []
    for user in users do
      if following_list.include? user.id
        @temp.push({first_name: user.first_name, username:user.username, show_profile: url_for(action:"show_profile", controller: "users", username: user.username), link: url_for(action:"unfollow", controller: "users", username: user.username)})
      else
        @temp.push({first_name: user.first_name, username:user.username, show_profile: url_for(action:"show_profile", controller: "users", username: user.username), link: url_for(action:"follow", controller: "users", username: user.username)})
      end
    end
    return @temp
  end
  def filterSearchResultsForJson(users)
    @temp = []
    for user in users
      @temp.push({first_name: user.first_name, last_name:user.last_name, username:user.username, show_profile: url_for(action:"show_profile", controller: "users", username: user.username)})
    end
    return @temp
  end
end
