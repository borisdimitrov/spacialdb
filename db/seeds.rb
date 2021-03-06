# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

stripe_plans = [
  {amount: 1000, currency: "eur", interval: "month", interval_count: 1, name: "10€ / month", statement_descriptor: "10Eur/mon",
    metadata: {
      "Memory" => "512MB",
      "Processor" => "1 Core",
      "Storage" => "20GB",
      "Bandwidth" => "1TB"
    }
  },
  {amount: 2000, currency: "eur", interval: "month", interval_count: 1, name: "20€ / month", statement_descriptor: "20Eur/mon",
    metadata: {
      "Memory" => "1GB",
      "Processor" => "1 Core",
      "Storage" => "30GB",
      "Bandwidth" => "2TB"
    },
    featured: true
  },
  {amount: 4000, currency: "eur", interval: "month", interval_count: 1, name: "40€ / month", statement_descriptor: "40Eur/mon",
    metadata: {
      "Memory" => "2GB",
      "Processor" => "2 Core",
      "Storage" => "40GB",
      "Bandwidth" => "3TB"
    }
  },
  {amount: 8000, currency: "eur", interval: "month", interval_count: 1, name: "80€ / month", statement_descriptor: "80Eur/mon",
    metadata: {
      "Memory" => "4GB",
      "Processor" => "2 Core",
      "Storage" => "60GB",
      "Bandwidth" => "4TB"
    }
  }
]

Plan.create stripe_plans

client =  DropletKit::Client.new(access_token: Rails.application.secrets.digital_ocean_token)
client.regions.all().each do |region|
  next unless region.available
  Region.create [{slug: region.slug, name: region.name, available: region.available}]
end
