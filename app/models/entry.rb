# encoding: UTF-8
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
class Entry < ApplicationRecord
  acts_as_taggable

  include MarkdownExtension
  include AuthorExtension

  belongs_to :author
  belongs_to :blog
  has_many :comments, :as => :owner, :dependent => :destroy

  default_scope { includes(:author, :tags) }
  scope :by_date, -> { order("created_at DESC") }

  validates :title, :progress, :blog_id, :presence => true

  def self.search(query)
    slots = ['title', 'progress', 'plans', 'problems']
    conditions = slots.map { |slot| "#{slot} LIKE ?" }
    params = slots.map { |slot| "%#{query}%" }
    where(conditions.join(' OR '), *params)
  end

  before_save :regenerate_html

  def regenerate_html
    self.progress_html = progress ? md_to_html(progress) : ""
    self.plans_html    = plans    ? md_to_html(plans)    : ""
    self.problems_html = problems ? md_to_html(problems) : ""
  end
end
