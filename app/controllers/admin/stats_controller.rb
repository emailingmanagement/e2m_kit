class Admin::StatsController < ApplicationController
  def index
    @kits = Kit.all
  end
end
