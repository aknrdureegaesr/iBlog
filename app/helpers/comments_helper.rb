# Copyright 2014, 2015 innoQ Deutschland GmbH

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at

#     http://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

module CommentsHelper

  def avatar(author)
    uri = author.avatar_uri
    image_tag(uri.present? ? uri : image_url('greyface.png'), :class => "avatar", :alt => author.name)
  end

  def comment_owner_path(comment)
    anchor = "comment-#{comment.id}"

    if comment.owner.is_a?(Entry)
      blog_entry_path(comment.owner.blog, comment.owner, :anchor => anchor)
    elsif comment.owner.is_a?(WeeklyStatus)
      weekly_status_path(comment.owner, :anchor => anchor)
    end
  end

  def comment_owner_url(comment)
    anchor = "comment-#{comment.id}"

    if comment.owner.is_a?(Entry)
      blog_entry_url(comment.owner.blog, comment.owner, :anchor => anchor)
    elsif comment.owner.is_a?(WeeklyStatus)
      weekly_status_url(comment.owner, :anchor => anchor)
    end
  end
end
