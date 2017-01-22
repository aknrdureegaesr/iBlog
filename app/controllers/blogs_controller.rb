# encoding: utf-8
# Copyright 2014 innoQ Deutschland GmbH

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at

#     http://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

class BlogsController < ApplicationController

  def index
    @blogs = if params[:owner]
      Blog.includes(:author).by params[:owner]
    else
      Blog.includes(:author).all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.atom
      format.xml  { render :xml => @blogs }
    end
  end

  def show
    @blog = Blog.find(params[:id])

    respond_to do |format|
      format.html { redirect_to blog_entries_path(@blog) }
      format.xml  { render :xml => @blog }
    end
  end

  def new
    @blog = Blog.new
    @blog.author = Author.for_handle @user

    respond_to do |format|
      format.html { render :action => 'edit'}
      format.xml  { render :xml => @blog }
    end
  end

  def edit
    @blog = Blog.find(params[:id])
  end

  def create
    @blog = Blog.new(blog_params)
    @blog.author = @author

    respond_to do |format|
      if @blog.save
        flash[:success] = 'Das Blog wurde gespeichert.'
        format.html { redirect_to blog_entries_path(@blog) }
        format.xml  { render :xml => @blog, :status => :created, :location => @blog }
      else
        flash[:error] = 'Das Blog konnte nicht gespeichert werden.'
        format.html { render :action => "edit" }
        format.xml  { render :xml => @blog.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @blog = Blog.find(params[:id])

    respond_to do |format|
      if @blog.update_attributes(blog_params)
        flash[:success] = 'Das Blog wurde gespeichert.'
        format.html { redirect_to blog_entries_path(@blog) }
        format.xml  { head :ok }
      else
        flash[:error] = 'Das Blog konnte nicht gespeichert werden.'
        format.html { render :action => "edit" }
        format.xml  { render :xml => @blog.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @blog = Blog.find(params[:id])
    @blog.destroy
    flash[:info] = 'Das Blog wurde gelöscht.'

    respond_to do |format|
      format.html { redirect_to(blogs_url) }
      format.xml  { head :ok }
    end
  end

  private

  def blog_params
    params.require(:blog).permit(:name, :title, :description)
  end
end
