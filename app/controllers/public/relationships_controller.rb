class Public::RelationshipsController < ApplicationController
  before_action :authenticate_member!
  before_action :ensure_guest_member, only: [:create, :destroy]

  def create
    @member = Member.find(params[:member_id])
    current_member.follow(@member.id)
  end

  def destroy
    @member = Member.find(params[:member_id])
    current_member.unfollow(@member.id)
  end

  def followings
    member = Member.find(params[:member_id])
    @members = member.followings
  end

  def followers
    member = Member.find(params[:member_id])
    @members = member.followers
  end
end
