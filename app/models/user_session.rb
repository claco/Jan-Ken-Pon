class UserSession < Authlogic::Session::Base
  disable_magic_states(true)
end
