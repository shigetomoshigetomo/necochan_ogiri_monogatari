class Admin::ReportsController < ApplicationController
  before_action :authenticate_admin!

  def index
    if params[:status] == "all"
      @reports = Report.all.page(params[:page]).per(10)
    elsif params[:status]
      report_statuses = Report.where(status: params[:status])
      @reports = report_statuses.page(params[:page]).per(10)
    else
      @reports = Report.all.page(params[:page]).per(10)
    end
  end

  def show
    @report = Report.find(params[:id])
    @report_comment = ReportComment.new
    @report_comments = @report.report_comments
  end

  def update
    @report = Report.find(params[:id])
    if @report.update(report_params)
      redirect_to request.referer, notice: "対応ステータスを更新しました。"
    end
  end

  private

    def report_params
      params.require(:report).permit(:status)
    end
end