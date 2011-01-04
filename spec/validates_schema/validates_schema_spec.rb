require 'spec_helper'

describe "validates_schema" do

  before(:each) do
    @user = User.new
    @user.should_not be_valid
    # puts "@user.errors: #{@user.errors.inspect}"
  end
  
  describe "valid?" do
    
    it "should be valid with valid attributes" do
      @user = User.new(:password => 'password', :url => 'http://www.example.com',
                       :pin => 123, :name => 'Mark Bates', :email => 'mark@example.com',
                       :age => 32, :salt => rand, :summary => 'Ruby developer', :alive => true,
                       :salary => 1000000.00)
      @user.valid?
      @user.should be_valid
    end
    
  end
  
  describe "presence" do
    
    it "should validate not-null fields are present" do
      @user.should_not be_valid
      @user.errors[:password].should include("can't be blank")
      @user.errors[:url].should include("can't be blank")
      @user.errors[:pin].should include("can't be blank")
      
      @user.errors[:name].should_not include("can't be blank")
      @user.errors[:email].should_not include("can't be blank")
      @user.errors[:age].should_not include("can't be blank")
    end
    
  end
  
  describe "limit" do
    
    it "should validate fiels with limits" do
      %w{name password url email}.each {|f| @user.send("#{f}=", 'x' * 1000)}
      @user.should_not be_valid
      @user.errors[:name].should include("is too long (maximum is 200 characters)")
      @user.errors[:email].should include("is too long (maximum is 255 characters)")
      @user.errors[:password].should include("is too long (maximum is 255 characters)")
      @user.errors[:url].should include("is too long (maximum is 128 characters)")
    end
    
  end
  
  describe "numericality" do
    
    it "should validate numerical fields" do
      @user.pin = 'foo'
      @user.age = '58'
      
      @user.should_not be_valid
      @user.errors[:pin].should include("is not a number")
      @user.errors[:age].should_not include("is not a number")
    end
    
    it "should validate only_integer for integer fields" do
      @user.pin = 1234
      @user.age = 32.3
      @user.salt = '1234'
      
      @user.should_not be_valid
      @user.errors[:pin].should_not include("is not a number")
      @user.errors[:age].should include("must be an integer")
    end
    
  end

end
