class Admin::ReportCommentsController < ApplicationController
  before_action :authenticate_admin!

  def create
    @report = Report.find(params[:report_id])
    @report_comment = ReportComment.new(report_comment_params)
    @report_comment.report_id = @report.id
    if @report_comment.save
      flash[:notice] = "コメントを保存しました。"
      redirect_to request.referer
    else
      @report = Report.find(params[:report_id])
      @report_comments = ReportComment.where(report_id: @report.id)
      render "admin/reports/show"
    end
  end

  def destroy
    @report = Report.find(params[:report_id])
    @report_comment = ReportComment.find(params[:id])
    if @report_comment.destroy
      flash[:notice] = "コメントを削除しました。"
      redirect_to request.referer
    end
  end

  private

    def report_comment_params
      params.require(:report_comment).permit(:comment)
    end
end
