ActiveAdmin.register Campaign do

  index do
    column :brand
    column :twitter_account
    default_actions
  end


  show do |campaign|

    attributes_table do
      row :name
      row :brand
      row :twitter_account
    end

    panel "Triggers" do
      table_for(campaign.triggers) do
        column :name
        column :hashtag
        column :active
        column "Actions" do |trigger|
          link_to "View",  admin_trigger_path(trigger)
        end
      end
    end
  end

end
