ActiveAdmin.register Trigger do

show do |trigger|

    attributes_table do
      row :name
      row :campaign
      row :hashtag
      row :active
    end

    panel "Coupon Codes" do
      table_for(trigger.coupon_codes) do
        column :name
        column :value
        column :sent
        column :sent_to
        column :delivered
        column "Actions" do |coupon_codes|
          link_to "View",  admin_coupon_code_path(coupon_codes)
        end
      end
    end
  end

end
