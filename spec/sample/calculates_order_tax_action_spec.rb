require 'spec_helper'
require_relative 'tax/calculates_order_tax_action'

describe CalculatesOrderTaxAction do
  let(:order) { double('order') }
  let(:context) do
    data = { :order => order, :tax_percentage => 7.2 }
    ::LightService::Context.make(data)
  end

  it "calculates the tax based on the tax percentage" do
    order.stub(:total => 100)
    order.should_receive(:tax=).with 7.2
    CalculatesOrderTaxAction.execute(context)
  end
end
