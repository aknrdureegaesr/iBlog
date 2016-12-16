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

class WeeklyStatus < ApplicationRecord
  include MarkdownExtension
  include AuthorExtension

  belongs_to :author
  has_many :comments, :as => :owner, :dependent => :destroy

  default_scope { includes(:author) }

  validates :status, :presence => true

  before_save :regenerate_html

  def self.recent
    order('id DESC')
  end

  def self.by_week(week)
    begin
      start_time = Date.commercial(Time.now.year, week.to_i, 1)
      where('created_at >= :start AND created_at <= :end',
            { :start => start_time, :end => start_time.end_of_week })
    rescue ArgumentError => e
      raise ArgumentError, 'Invalid week number'
    end
  end

  def self.search(query)
    where('status LIKE ?', "%#{query}%")
  end

  def title
    timestamp = created_at? ? created_at : Time.now
    "Wochenstatus KW #{timestamp.strftime('%V')} von #{author.name}"
  end

  def regenerate_html
    self.status_html = status ? md_to_html(status) : ""
  end
end
