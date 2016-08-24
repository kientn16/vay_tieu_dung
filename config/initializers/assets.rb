# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

Rails.application.config.assets.precompile += %w( frontend/bootstrap.min.css )
Rails.application.config.assets.precompile += %w( plugins/ion-rangeSlider/css/ion.rangeSlider.css )
Rails.application.config.assets.precompile += %w( plugins/ion-rangeSlider/css/ion.rangeSlider.skinHTML5.css )
Rails.application.config.assets.precompile += %w( plugins/swiper-3.3.1/css/swiper.css )
Rails.application.config.assets.precompile += %w( frontend/styles.css )

Rails.application.config.assets.precompile += %w( frontend/jquery.1.12.4.min.js )
Rails.application.config.assets.precompile += %w( frontend/bootstrap.min.js )
Rails.application.config.assets.precompile += %w( plugins/ion-rangeSlider/ion.rangeSlider.js )
Rails.application.config.assets.precompile += %w( plugins/swiper-3.3.1/js/swiper.jquery.min.js )
Rails.application.config.assets.precompile += %w( frontend/custom.js )
# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
