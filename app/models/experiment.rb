class Experiment < ActiveRecord::Base
  belongs_to :tenant
  validates_uniqueness_of :title
  has_many :artifacts, dependent: :destroy
  has_many :user_experiments
  has_many :users, through: :user_experiments
  validate :free_plan_can_only_have_one_project
  
  def free_plan_can_only_have_one_project
    if self.new_record? && (tenant.experiments.count > 0)  && (tenant.plan == 'free')
      errors.add(:base, "Free plans cannot have more than one experiment.")
    end  
  end  
  
  def self.by_user_plan_and_tenant(tenant_id, user)
    tenant = Tenant.find(tenant_id)
    if tenant.plan == 'premium'
      if user.is_admin?
       tenant.experiments
      else
        user.experiments.where(tenant_id: tenant.id)
      end  
    else
      if user.is_admin?  
       tenant.experiments.order(:id).limit(1)
      else
        user.experiments_where(tenant_id: tenant.id).order(:id).limit(1)
      end  
    end  
  end  
end
