ActiveAdmin.register Brand do
  
  show do |brand|

    attributes_table do
      row :name
      row :logo do
        image_tag(brand.logo)
      end
    end

    panel "Campaigns" do
      table_for brand.campaigns do
        column "name" do |campaign|
          link_to campaign.name, admin_campaign_path
        end

        column "Twitter Account" do |campaign|
          link_to campaign.twitter_account.name, admin_twitter_account_path
        end
      end
    end
  end

end
