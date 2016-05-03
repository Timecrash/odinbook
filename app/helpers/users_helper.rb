module UsersHelper
  #Returns either the user's uploaded avatar or their Gravatar.
  #Favors the former.
  def avatar(user, options = { size: 80 })
    size = options[:size]
    #image_tag(user.avatar.url, size: size) if user.avatar
    gravatar_for(user, size)
  end
  
  def gravatar_for(user, size = 80)
    gravatar_id  = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
end
