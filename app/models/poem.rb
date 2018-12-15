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
      [{poem: line.poem.map{|single_line| single_line.slice(:id, :content, :created_at).merge(user: single_line.user.slice(:id, :name))}, likes: line.likes.count}]
    else
      line.next_lines.each do |next_line|
        versions += find_versions(next_line, versions)
      end
      versions
    end
  end

  def first_version
    last_line = self.first_line
    while !last_line.next_lines.empty?
      last_line = last_line.next_lines.first
    end
    {poem: last_line.poem.map{|single_line| single_line.slice(:id, :content, :created_at).merge(user: single_line.user.slice(:id, :name))}, likes: last_line.likes.count}
  end

  def best_version
    self.all_versions.max_by{|poem| poem[:likes] }
  end
end
