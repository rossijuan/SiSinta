# -*- encoding : utf-8 -*-
SiSINTA::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request.  This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true

  # Habilito el cache para pruebas
  config.action_controller.perform_caching = true
  config.cache_store = :libmemcached_store

  # Para testear Devise
  config.action_mailer.default_url_options = { host: 'localhost:3000' }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.default charset: "utf-8"

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # Do not compress assets
  config.assets.compress = false

  # Expands the lines which load the assets
  config.assets.debug = true

  # Cómo guardar los archivos adjuntos. Usa la interpolación de Paperclip y el
  # símbolo :url que está definido en el modelo Adjunto
  config.adjunto_path = '/var/tmp/sisinta-dev:url'

  # Raise exception on mass assignment protection for Active Record models
  config.active_record.mass_assignment_sanitizer = :strict

  # Log the query plan for queries taking more than this (works
  # with SQLite, MySQL, and PostgreSQL)
  config.active_record.auto_explain_threshold_in_seconds = 0.5

  # Bullet
  config.after_initialize do
    Bullet.enable = true
    Bullet.bullet_logger = true
    Bullet.console = true
  end

  # Configuración de ejemplo para riseup.net
  ActionMailer::Base.smtp_settings = {
    address: 'mail.riseup.net',

    # usar TLS
    enable_starttls_auto: true,

    # puerto para TLS
    port:                 587,

    # dominio desde el que enviamos
    domain:               'dominio.com.ar',

    user_name:            'nombre de usuario',
    password:             'password',

    # envía en texto plano pero envuelto en TLS
    authentication:       :plain
  }

end
