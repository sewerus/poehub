class Line < ApplicationRecord
  belongs_to :user
  belongs_to :previous_line, class_name: 'Line', foreign_key: 'previous_line_id', primary_key: 'id', optional: true
  has_many :likes

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
end
