class HelloController < ApplicationController
  skip_before_action :verify_authenticity_token
  def sayHi
        render json:'Hello World!!'
  end
end
