if Rails.env.staging? || Rails.env.production? || Rails.env.steinpilz?
  SMTP_SETTINGS = {
    address: ENV.fetch('SMTP_ADDRESS'), 
    authentication: :plain,
    domain: ENV.fetch('SMTP_DOMAIN'),
    password: ENV.fetch('SMTP_PASSWORD'),
    port: '587',
    user_name: ENV.fetch('SMTP_USERNAME')
  }
end
