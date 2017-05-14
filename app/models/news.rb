class News < ActiveRecord::Base

  belongs_to :user

  serialize :classes, Array

  enum type: { photo: 0, video: 1 }

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
