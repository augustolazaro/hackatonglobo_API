class News < ActiveRecord::Base
  include Filterable

  belongs_to :user
  belongs_to :group

  serialize :tags

  # Scopes
  scope :initial_date, -> (initial_date) { where("created_at >= ?", Time.at(initial_date.to_i/1000)) }
  scope :final_date, -> (final_date) { where("created_at <= ?", Time.at(final_date.to_i/1000)) }
  scope :category, -> (category) { where("created_at LIKE ?", category) }

  after_save :check_group

  def check_group
    previous_news = News.where("category = ? and created_at <= ?", self.category, self.created_at + 5.hours)
    previous_news.each do |base_news|
      count = 0
      self.tags.each do |tag|
        if base_news.tags.include?(tag)
          count += 1
        end
      end

      size = self.tags.size
      if (count/size) > 0.7
        if base_news.group.present?
          self.update_attributes(group: base_news.group)
        else
          group = Group.create(category: self.category)
          base_news.update_attributes(group: group)
          self.update_attributes(group: base_news.group)
          return
        end
      end
    end
  end

end
