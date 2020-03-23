module Plan
  PLANS = %w[free premium business]

  NAMES = %w[premium_monthly premium_quarterly premium_annually business_annually]

  PRICES = {
    premium: {
      monthly: 900,
      quarterly: 4500,
      annually: 10800
    },
    business: {
      annually: 2400
    }
  }

  INTERVALS = %w[monthly quarterly annually]
end

