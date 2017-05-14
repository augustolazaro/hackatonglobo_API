class News < ActiveRecord::Base
  include Filterable

  belongs_to :user

  # Scopes
  scope :initial_date, -> (initial_date) { where("created_at >= ?", initial_date) }
  scope :final_date, -> (final_date) { where("created_at <= ?", final_date) }
  scope :category, -> (category) { where("created_at LIKE ?", category) }

  def set_analyses
    file = File.read("#{ Root.path.join('tmp', 'response.json') }")
    classes = []
    analyses_json = JSON.parse(file)
    analyses_json['images'].each do |image|
      image['classifiers'].each do |klass|
        classes << klass['class']
      end
    end

    self.classes = classes
  end

end
