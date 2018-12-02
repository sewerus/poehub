class Line < ApplicationRecord
  belongs_to :user
  belongs_to :previous_line, class_name: 'Line', foreign_key: 'previous_line_id', primary_key: 'id', optional: true

  def next_lines
    Line.where(previous_line: self.id)
  end
end
