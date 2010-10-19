#!/usr/bin/env ruby

require File.expand_path('../../lib/clusterable', __FILE__)
require 'csv'
require 'benchmark'

points = []

CSV.foreach(File.expand_path('../points.csv', __FILE__)) do |row|
  latitude = row[0].to_f
  longitude = row[1].to_f
  
  if latitude > 0.0 && longitude > 0.0
    points << Clusterable::Point.new(latitude, longitude)
  end
end

time = Benchmark.measure do
  clusters = Clusterable::Cluster.kmeans(points, 12, 0.05)
  clusters.each do |cluster|
    puts "#{cluster.center} has #{cluster.points.size} #{cluster.points.size == 1 ? 'point' : 'points'}"
  end
end

puts "Time taken: #{time}"
