module Clusterable
  class Cluster
    attr_accessor :points, :center

    def initialize(points = [], center = nil)
      raise "can't initialize an empty cluster" unless points.size > 0
      self.points = points
      self.center = center || calculate_center
    end
    
    # See: http://en.wikipedia.org/wiki/K-means_clustering
    def self.kmeans(points, sample_size, distance_cutoff)
      initial  = pick_random(points, sample_size)
      clusters = initial.map do |point|
                   new([point], point) 
                 end
      
      while true
        lists = []
        clusters.each { lists << [] }
        
        points.each do |point|
          smallest_distance = point.distance_to(clusters.first.center)
          index = 0
          
          clusters[1..clusters.length].each.with_index do |cluster, i|
            distance = point.distance_to(cluster.center)
            
            if distance < smallest_distance
              smalles_distance = distance
              index = i + 1
            end
          end
          
          lists[index] << point
        end
        
        biggest_shift = 0.0
        clusters.each.with_index do |cluster, index|
          if lists[index].size > 0
            shift = cluster.update(lists[index])
            biggest_shift = [shift, biggest_shift].max
          end
        end
        
        break if biggest_shift < distance_cutoff
      end
      
      clusters
    end
    
    def update(points)
      self.points = points.compact
      old_center  = center.dup
      self.center = calculate_center
      
      center.distance_to(old_center)
    end
    
    private
    
    # This random array picker should be optimized for speed,
    # but this is untested. 
    def self.pick_random(array, number_of_items)
      size    = array.size
      indexes = []
      
      number_of_items.times do
        random = rand(size) while random.nil? || indexes.include?(random)
        indexes << random
      end
      
      indexes.map do |index|
        array[index]
      end
    end
    
    def calculate_center
      latitude  = points.inject(0.0) { |sum, point| sum + point.latitude  } / points.length
      longitude = points.inject(0.0) { |sum, point| sum + point.longitude } / points.length
      
      Point.new(latitude, longitude)
    end
  end
end
