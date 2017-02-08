# encoding: utf-8
# Copyright 2014,2015 innoQ Deutschland GmbH

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at

#     http://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

class WeeklyStatusesController < ApplicationController
  def index
    @statuses = WeeklyStatus.recent.page(params[:page]).per(150)

    respond_to do |format|
      format.html
      format.atom
    end
  end

  def by_author
    @author = Author.for_handle params[:author]
    @statuses = WeeklyStatus.where('author_id = ?', @author.id).recent

    respond_to do |format|
      format.html do
        @statuses = @statuses.page(params[:page])
        render :index
      end
      format.atom { render :index }
    end
  end

  def by_week
    begin
      @statuses = WeeklyStatus.by_week(params[:week]).recent
      respond_to do |format|
        format.html
      end
    rescue ArgumentError => e
      flash[:error] = e.message
      redirect_to weekly_statuses_by_week_path(Time.now.strftime('%V'))
    end
  end

  def show
    @status = WeeklyStatus.includes(:comments)
                          .references(:comments)
                          .find(params[:id])
    @edit_comment = @status.comments.new
    @comments = @status.comments
  end

  def new
    @status = WeeklyStatus.new do |s|
      s.author = @author
    end

    render :edit
  end

  def create
    @status = WeeklyStatus.new(weekly_status_params)
    @status.author = @author
    if params[:commit] == "Vorschau"
      @status.regenerate_html
      @preview = true
      render :edit
    elsif @status.save
      flash[:success] = "Der Eintrag wurde gespeichert."
      redirect_to weekly_statuses_path
    else
      flash[:error] = "Der Eintrag konnte nicht gespeichert werden."
      render :edit
    end
  end

  def edit
    @status = WeeklyStatus.find(params[:id])
  end

  def update
    @status = WeeklyStatus.find(params[:id])
    if params[:commit] == "Vorschau"
      @status.assign_attributes(weekly_status_params)
      @status.regenerate_html
      @preview = true
      render :edit
    elsif @status.owned_by? @user
      if @status.update_attributes(weekly_status_params)
        flash[:success] = "Der Eintrag wurde geändert."
        redirect_to weekly_statuses_path
      else
        flash[:error] = "Der Eintrag konnte nicht geändert werden."
        render :edit
      end
    else
      head :unauthorized
    end
  end

  def destroy
    @status = WeeklyStatus.find(params[:id])
    if @status.owned_by?(@user) && @status.destroy
      flash[:success] = "Der Eintrag wurde gelöscht."
    else
      flash[:error] = "Der Eintrag konnte nicht gelöscht werden."
    end

    redirect_to weekly_statuses_path
  end

  private

  def weekly_status_params
    params.require(:weekly_status).permit(:status)
  end
end
