class Admin::ReportsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @reports = Report.all
  end

  def show
    @report = Report.find(params[:id])
    @report_comment = ReportComment.new
    @report_comments = ReportComment.where(report_id: @report.id)
  end

  def update
    @report = Report.find(params[:id])
    if @report.update(report_params)
      flash[:notice] = "対応ステータスを更新しました。"
      redirect_to request.referer
    end
  end

  private

    def report_params
      params.require(:report).permit(:status)
    end
end
