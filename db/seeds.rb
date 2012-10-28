# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Brand.delete_all

brands = Brand.create([
  { :name => 'Testy Brand'},
  { :name => 'Tester Brandy'}
])

TwitterAccount.delete_all

twitter_accounts = TwitterAccount.create([
  {
    :name => 'twit acct 1',
    :handle => '@dariusdarius',
    :description => 'lore ipsum',
    :consumer_key => '123key',
    :consumer_secret => '123key',
    :access_token => '123access',
    :access_token_secret => '123secret'
  },
  {
    :name => 'twit acct 2',
    :handle => '@dariusdarius2',
    :description => 'lore ipsum',
    :consumer_key => '123key',
    :consumer_secret => '123key',
    :access_token => '123access',
    :access_token_secret => '123secret'
  }
])

Campaign.delete_all

campaigns = Campaign.create([
  { :name => 'Camp 1', :brand_id => 1, :twitter_account_id => 1 },
  { :name => 'Camp 2', :brand_id => 2, :twitter_account_id => 2 }
])

Trigger.delete_all

triggers = Trigger.create([
  {
    :name => 'Trigger 1',
    :campaign_id => 1,
    :hashtag => 'cnvrsltest',
    :active => 1
  },
  {
    :name => 'Trigger 2',
    :campaign_id => 2,
    :hashtag => 'cnvrsltest2',
    :active => 1
  }
])

CouponCode.delete_all

coupon_codes = CouponCode.create([
  {
    :name => 'coupon code 1',
    :trigger_id => 1,
    :value => '123coupon',
    :sent => 0,
    :sent_to => nil,
    :delivered => 0
  }
])

Message.delete_all

messages = Message.create([
  {
    :name => 'msg 1',
    :trigger_id => 1,
    :body => '{code} and stuff and things'
  }
])