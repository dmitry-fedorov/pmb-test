# README

# Installation:
- bin/setup
- bin/rails s

It will install gems, create database and populate it with some initial messages

# Rspec
As rspec uses poltergeist as js driver you may need to install phatnomjs
- brew cask install phantomjs
  
To run tests type
- bundle exec rspec

There are 2 typee of specs:
1) Integration (lays under spec/features)
2) Unit (currently only one spec for ActionCable. Lays under spec/commands)

Note: I did not write specs for controller since we have integration specs which covers controller functionality

# What included?
- Visitor/user could see all messages on page (pagination included)
- Visitor/user could create/update/delete messages
- Visitor could update/delete all anonymous messages (could be handled by session to make behavior like visitor is authenticated in future)
- User could update/delete his own messages
- Visitor/user could open many tabs and see page updates in each of them without page reload (ActionCable is used as messaging basis)
- Validation errors is rendered by json (Errors could be shown on page in future if needed)

# Note
There are couple of known design bugs (e.g if we add message on full board). We could fix it by js handling index method but I thought it's a bit excess in terms of the task
