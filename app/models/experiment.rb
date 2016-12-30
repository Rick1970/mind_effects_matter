class Experiment < ActiveRecord::Base
  belongs_to :tenant
  validates_uniqueness_of :title
  has_many :artifacts, dependent: :destroy
  validate :free_plan_can_only_have_one_project
  
  def free_plan_can_only_have_one_project
    if self.new_record? && (tenant.experiments.count > 0)  && (tenant.plan == 'free')
      errors.add(:base, "Free plans cannot have more than one experiment.")
    end  
  end  
  
  def self.by_plan_and_tenant(tenant_id)
    tenant = Tenant.find(tenant_id)
    if tenant.plan == 'premium'
      tenant.experiments
    else
      tenant.experiments.order(:id).limit(1)
    end  
  end  
end
