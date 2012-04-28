class Profile < ActiveRecord::Base
  belongs_to :user
  
  def rank
    Profile.rankings(self).count+1
  end
  
  def higher_ten
    Profile.higher_ranked_profiles(self).order("points asc").limit(10)
  end
  
  def lower_ten
    Profile.lower_ranked_profiles(self).order("points asc").limit(10)
  end
  
  scope :rankings, lambda { |profile| where('points>?',profile.points) }
  scope :higher_ranked_profiles, lambda{ |profile| where('points>?',profile.points) }
  scope :lower_ranked_profiles, lambda{ |profile| where('points<?',profile.points) }
  
end
