class Tweet < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :tweeter_user

  def still_valid?
    created_at = self.created_at
    now = Time.now
    if now - created_at > 10
      false
    else
      true
    end
  end
end
