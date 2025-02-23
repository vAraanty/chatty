module Users
  class SearchController < ApplicationController
    def index
      @query = params[:query]

      if @query.present?
        @users = User.search(params[:query])
      else
        @users = User.none
      end
    end
  end
end
