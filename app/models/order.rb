class Order < ActiveRecord::Base
  include Statesman::Adapters::ActiveRecordQueries[transition_class: OrderTransition, initial_state: :pending]
  belongs_to :shipping_type, optional: true
  has_many :line_items
  has_one :address, :dependent => :destroy
  has_many :transitions, class_name: "OrderTransition", autosave: true

  accepts_nested_attributes_for :address

  delegate :can_transition_to?, :transition_to!, :transition_to, :current_state,
    to: :state_machine

  def state_machine
    @state_machine ||= OrderStateMachine.new(self, transition_class: OrderTransition,
                                             association_name: :transitions)
  end

  def full_cost
    line_items.map { |e| e.full_price.to_d }.sum + shipping_cost.to_d
  end

  def self.transition_class
    OrderTransition
  end

  def self.initial_state
    OrderStateMachine.initial_state
  end

  def self.transition_name
    :transitions
  end
end
