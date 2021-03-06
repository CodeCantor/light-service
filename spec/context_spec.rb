require "spec_helper"

module LightService
  describe Context do
    subject { Context.new(Outcomes::SUCCESS, "some_message", {:test => 1}) }

    it "initializes the object with default arguments" do
      service_result = Context.new
      service_result.should be_success
    end

    it "initializes the object with the context" do
      service_result = Context.new.tap { |o| o.add_to_context({:test => 1})}
      service_result.should be_success
      service_result.message.should eq ""
      service_result[:test].should eq 1
    end

    it "initializes the object with make" do
      service_result = Context.make({:test => 1})
      service_result.should be_success
      service_result.message.should eq ""
      service_result[:test].should eq 1
    end

    context "when created" do
      it { should be_success }
    end

    it "allows to set success" do
      subject.set_success!("the success")
      subject.should be_success
      subject.message.should == "the success"
    end

    specify "evaluates failure?" do
      subject.set_success!("the success")
      subject.should_not be_failure
    end

    it "allows to set failure" do
      subject.set_failure!("the failure")
      subject.should_not be_success
      subject.message.should == "the failure"
    end

    it "lets setting a group of context values" do
      subject.context_hash.should include(:test => 1)
      subject.context_hash.keys.length.should == 1

      subject.add_to_context(:test => 1, :two => 2)

      subject.context_hash.keys.length.should == 2
      subject.context_hash.should include(:test => 1)
      subject.context_hash.should include(:two => 2)
    end
  end

end
