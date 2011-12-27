require 'spec_helper'

describe Clusterable::Point do
  describe 'instance methods' do
    let(:marker) { Clusterable::Point.new(50.9985319, 5.8573735) }
    
    describe '#initialize' do
      let(:marker) { Clusterable::Point.new('latitude', 'longitude') }
      
      it 'sets the latitude' do
        marker[:latitude].should eql('latitude')
      end
      
      it 'sets the longitude' do
        marker[:longitude].should eql('longitude')
      end
    end
    
    describe '#latitude' do
      it 'returns the latitude' do
        marker.latitude.should eql(marker[:latitude])
      end
    end
    
    describe '#longitude' do
      it 'returns the longitude' do
        marker.longitude.should eql(marker[:longitude])
      end
    end
    
    describe '#distance_to' do
      let(:target) { Clusterable::Point.new(50.8889999, 5.9773202) }
      
      it 'returns the distance to another point' do
        marker.distance_to(marker).should eql(0.0)
        marker.distance_to(target).should eql(0.16243297037513815)
      end
    end
    
    describe '#to_s' do
      it 'returns the point as a string' do
        marker.to_s.should eql('50.9985319, 5.8573735')
      end
    end
  end
end
