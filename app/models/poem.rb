class Poem < ApplicationRecord
  belongs_to :user
  has_one :first_line, class_name: 'Line', primary_key: 'first_line_id', foreign_key: 'id'
  has_many :subscribes
  has_and_belongs_to_many :tags, join_table: 'poems_tags'

  scope :most_observed, -> {where id: Subscribe.group("poem_id").order("count_user_id desc").count("user_id").keys[0..9]}

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

  def save_if_has_lines(lines)
    if lines.empty?
      false
    else
      if self.save
        self.add_new_lines(lines)
      else
        false
      end
    end
  end

  def add_new_line(content, previous_line_id)
    new_line = Line.new
    new_line.content = content
    new_line.user = self.user
    new_line.previous_line_id = previous_line_id
    new_line.save!
    new_line.id
  end

  def add_new_lines(new_lines_hash)
    lines_content = new_lines_hash["lines"].split("\r\n")

    #for not first version but another ones
    first_line = new_lines_hash["first_line_id"]

    unless lines_content.empty?
      #first line
      previous_line_id = self.add_new_line(lines_content.shift, first_line)

      #for only first version but not another ones
      if first_line.nil?
        self.first_line_id = previous_line_id
        self.save!
      end

      #another lines
      lines_content.each do |content|
        previous_line_id = self.add_new_line(content, previous_line_id)
      end
    end
    true
  end

  def can_modify?(user)
    user.has_role? :admin or self.user.id = user.id
  end

  def toggle_subscribe(user)
    if user.subscribed_poems.include?(self)
      user.subscribed_poems.delete(self)
    else
      user.subscribed_poems << self
    end
  end
end
