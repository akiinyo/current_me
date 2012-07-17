module CurrentMe
  class Railtie < ::Rails::Railtie
    initializer 'CurrentMe' do |app|
      ActiveSupport.on_load :action_controller do
        ::ActionController::Base.send :include, CurrentMe
      end
    end
  end
end
