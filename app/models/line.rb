class Line < ApplicationRecord
  belongs_to :user
  belongs_to :previous_line, class_name: 'Line', foreign_key: 'previous_line_id', primary_key: 'id', optional: true
  has_many :likes

  scope :most_liked, -> {where id: Like.group("line_id").order("count_user_id desc").count("user_id").take(10)}

  def next_lines
    Line.where(previous_line: self.id)
  end

  #return all previous lines
  def poem
    if !self.previous_line.nil?
      self.previous_line.poem + [self]
    else
      [self]
    end
  end

  def poem_version
    {poem_id: Poem.where(first_line_id: self.poem.first.id).first.id, poem: self.poem.map{|single_line| single_line.slice(:id, :content, :created_at).merge(user: single_line.user.slice(:id, :name))}, likes: self.likes.count}
  end

  def toggle_like(user)
    if user.favourite_lines.include?(self)
      user.favourite_lines.delete(self)
    else
      user.favourite_lines << self
    end
  end
end
