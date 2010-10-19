module Clusterable
  class Point < Hash
    def initialize(latitude, longitude)
      self[:latitude]  = latitude
      self[:longitude] = longitude
    end
    
    def latitude
      self[:latitude]
    end
    
    def longitude
      self[:longitude]
    end
    
    def distance_to(target)
      Math.sqrt(
        ((latitude  - target.latitude ) ** 2) +
        ((longitude - target.longitude) ** 2)
      )
    end
    
    def to_s
      [latitude, longitude].join(", ")
    end
  end
end
