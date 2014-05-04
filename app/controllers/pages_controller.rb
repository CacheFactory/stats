class PagesController < ApplicationController
  caches_page :index, :expires_in => 5.minutes
  def index
    @data_hash = {top_urls: ReportMaker.top_urls,
                  top_referrers: ReportMaker.top_referrers}
  end
end
