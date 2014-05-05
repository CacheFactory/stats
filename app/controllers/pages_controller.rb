class PagesController < ApplicationController
  caches_page :index, :top_urls ,:top_referrers, :expires_in => 5.minutes
  def index
    @data_hash = {top_urls: ReportMaker.top_urls,
                  top_referrers: ReportMaker.top_referrers}
  end

  def top_urls
    render json: ReportMaker.top_urls
  end

  def top_referrers
    render json: ReportMaker.top_referrers
  end
end
