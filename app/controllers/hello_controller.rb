class HelloController < ApplicationController
  def sayHi
        render json:'Hello World!!'
  end
end
