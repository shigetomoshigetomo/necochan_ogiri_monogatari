class Public::ReportsController < ApplicationController
  before_action :authenticate_member!
  before_action :ensure_guest_member

  def new
    @report = Report.new
    @member = Member.find(params[:member_id])
  end

  def create
    @member = Member.find(params[:member_id])
    @report = Report.new(report_params)
    @report.reporter_id = current_member.id
    @report.reported_id = @member.id
    if @report.save
      redirect_to member_path(@member), notice: "ご報告ありがとうございます。運営の参考とさせて頂きます。"
    else
      render "new"
    end
  end

  private

  def report_params
    params.require(:report).permit(:reason, :url)
  end
end
