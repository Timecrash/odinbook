module UsersHelper
  #Returns either the user's uploaded avatar or their Gravatar.
  def avatar(user, options = { size: 80, style: :avatar })
    size = options[:size]
    style = options[:style]
    default = "/avatars/original/missing.png"
    if user.avatar.url == default
      gravatar_for(user, size)
    else
      image_tag user.avatar.url(style), class: "avatar"
    end
  end
  
  def gravatar_for(user, size = 80)
    gravatar_id  = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "avatar")
  end
end
