class Admin::ReportCommentsController < ApplicationController
  before_action :authenticate_admin!

  def create
    @report = Report.find(params[:report_id])
    @report_comment = ReportComment.new(report_comment_params)
    @report_comment.report_id = @report.id
    if @report_comment.save
      @report_comments = @report.report_comments
      flash.now[:notice] = "コメントを保存しました。"
    else
      @report_comments = @report.report_comments
    end
  end

  def destroy
    @report = Report.find(params[:report_id])
    @report_comment = ReportComment.find(params[:id])
    if @report_comment.destroy
      @report_comments = @report.report_comments
      flash.now[:notice] = "コメントを削除しました。"
    end
  end

  private

  def report_comment_params
    params.require(:report_comment).permit(:comment)
  end
end
