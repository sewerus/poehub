class Poem < ApplicationRecord
  belongs_to :user
  has_one :first_line, class_name: 'Line', primary_key: 'first_line_id', foreign_key: 'id'
  has_many :subscribes
  has_and_belongs_to_many :tags, join_table: 'poems_tags'

  def all_versions
    find_versions(self.first_line, [])
  end

  def find_versions(line, versions)
    if line.next_lines.empty?
      puts line.id
      [line.poem]
    else
      puts "next"
      line.next_lines.each do |next_line|
        versions += find_versions(next_line, versions)
      end
      versions
    end
  end
end
