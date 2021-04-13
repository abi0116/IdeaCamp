class Company < ApplicationRecord

  belongs_to :member

  enum status: {
      unapplied: 0,#未申請
      application: 1,#申請中
      acceptance: 2,#受理
      rejected: 3#却下
  }

end
