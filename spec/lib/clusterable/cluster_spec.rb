require 'spec_helper'

describe Clusterable::Cluster do
  def random_point(lat = nil, lng = nil)
    Clusterable::Point.new(lat || 50.9985319,
                           lng ||  5.8573735)
  end
  
  describe 'instance methods' do
    describe '#initialize' do
      it 'returns a cluster' do
        Clusterable::Cluster.new([random_point]).should be_an_instance_of(Clusterable::Cluster)
      end
      
      it 'requires at least 1 point' do
        lambda {
          Clusterable::Cluster.new([])
        }.should raise_error
      end
      
      it 'sets the points attribute' do
        points  = [random_point]
        cluster = Clusterable::Cluster.new(points)
        
        cluster.points.should eql(points)
      end
      
      it 'accepts an optional center point' do
        lambda {
          Clusterable::Cluster.new([random_point], random_point)
        }.should_not raise_error
      end
      
      it 'sets the center attribute to the specified center point' do
        center  = random_point
        cluster = Clusterable::Cluster.new([random_point], center)
        cluster.center.should eql(center)
      end
      
      it 'calculates the center point if unspecified' do
        points  = [random_point(50, 5), random_point(60, 10)]
        cluster = Clusterable::Cluster.new(points)
        
        cluster.center.should_not be_nil
        cluster.center.latitude.should  eql(55.0)
        cluster.center.longitude.should eql(7.5)
      end
    end
    
    describe '#update' do
      let(:cluster) { Clusterable::Cluster.new([random_point]) }
      let(:target)  { Clusterable::Point.new(50.8889999, 5.9773202) }
      
      it 'overwrites the points attribute' do
        points = [target]
        cluster.update(points)
        
        cluster.points.should eql(points)
      end
      
      it 'recalculates the center point' do
        points = [random_point(50, 5)]
        cluster.update(points)
        
        cluster.center.latitude.should  eql(50.0)
        cluster.center.longitude.should eql(5.0)
      end
      
      it 'returns the distance from the old center to the new center' do
        cluster.update([target]).should eql(0.16243297037513815)
      end
    end
  end
end
