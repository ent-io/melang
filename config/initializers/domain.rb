module Melang
  APP_DOMAIN    = ENV['APP_DOMAIN']     || 'melangapp.com'
  BUCKET_DOMAIN = ENV['BUCKET_DOMAIN']  || "b.#{APP_DOMAIN}"
end
