module Cloudifiable
  def normalize
    weights = self.values
    norm_factor = 10.0 / weights.max
    inject({}) do |normalized, item|
      name, weight = item
      normalized[name] = (weight * norm_factor).floor
      normalized
    end
  end
  def cloudify(sort_mode=:desc)
    items = normalize
    items = case sort_mode
    when :desc
      items.sort_by { |item| name, weight = item; weight }.reverse
    when :shuffle
      items.sort_by { rand }
    end
    items.map do |name, weight|
      "<span class=\"cw_#{weight}\">#{name}</span>"
    end.join(" ")
  end
end

class Vapor
  def self.cloudify(path)
    hashes = YAML::load(File.read(path))
    hashes.map { |_, hash| hash.cloudify }    
  end
  
end