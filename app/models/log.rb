class Log < ActiveRecord::Base
  belongs_to :training_session, :inverse_of => :logs
  belongs_to :user, class_name: 'LocalUser', :inverse_of => :logs

  validates :comment, :length => { :minimum => 1 }, allow_nil: false, allow_blank: false


  def get_intensity
    case self.intensity
      when 1
        return "very easy"
      when 2
        return "easy"
      when 3
        return "middle"
      when 4
        return "hard"
      when 5
        return "very hard"
      else
        return "N/A"
    end
  end

  def get_rating
    case self.rating
      when 1
        return "very bad"
      when 2
        return "bad"
      when 3
        return "average"
      when 4
        return "good"
      when 5
        return "best"
      else
        return "N/A"
    end
  end
end
