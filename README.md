# odinbook

The Odin Project's [Final Rails Project](http://www.theodinproject.com/ruby-on-rails/final-project).

This is a fully functional social network in the Facebook mold, implementing the following:

Features already implemented will be *italicized*.

1. *PostgreSQL database.*
2. *Root sign-in page.*
3. Signing in via [Devise](https://github.com/plataformatec/devise).
4. Friend requests!
5. ...that require confirmation!
6. ...with notifications in the navbar.
7. Also, a navbar.
8. Posts!
9. ...that can be liked!
10. ...and commented upon!
11. Posts should display content, the author, comments, and likes.
12. A Facebook-esque Timeline, with recent posts made by the current user and their friends.
13. User profiles, with a Gravatar photo.
14. Profiles should **show** their profile info, photo, and posts.
15. An **index** containing users, with buttons for sending/accepting friend requests.
16. Sign-in via [OmniAuth](https://github.com/plataformatec/devise/wiki/OmniAuth:-Overview), allowing a user to sign-in through Facebook.
17. A mailer, sending a welcome e-mail for new users and a password retrieval e-mail.
18. [SendGrid](https://devcenter.heroku.com/articles/sendgrid) to actually send the e-mails.
19. Posts that can accept images!
20. ...and can also be uploaded from the client's computer.
21. Polymorphic association, which allows users to comment/like posts and photos without (much) extra code.