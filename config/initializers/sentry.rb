Raven.configure do |config|
  config.sanitize_fields = Rails.application.config.filter_parameters.map(&:to_s)
  config.dsn = 'https://524cdb271da14894b5d285a614dbb46e:a334325c1cec47309d50ed680e1968f2@app.getsentry.com/95398'
  config.environments = ['production']
end