class Subscription < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :account, optional: true

  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 1 }

  def on_trial?
    trial_ends_at? && Time.zone.now < trial_ends_at
  end

  def cancelled?
    ends_at?
  end

  # Determines if user can still resume subscription
  def on_grace_period?
    cancelled? && Time.zone.now < ends_at
  end

  def active?
    ends_at.nil? || on_grace_period? || on_trial?
  end

  def cancel
    stripe_subscription.cancel_at_period_end = true
    stripe_subscription.save

    new_ends_at = on_trial? ? trial_ends_at : Time.at(subscription.current_period_end)
    update(ends_at: new_ends_at)
  end

  def cancel_now!
    stripe_subscription.delete
    update(ends_at: Time.zone.now, trial_ends_at: nil)
  end

  def resume
    raise StandardError, "You can only resume subscriptions within their grace period." unless on_grace_period?

    stripe_subscription.cancel_at_period_end = false
    stripe_subscription.save
    update(ends_at: nil)
  end

  def stripe_subscription
    @stripe_subscription ||= Stripe::Subscription.retrieve(stripe_id)
  end
end
