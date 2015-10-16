module ShotsHelper
  def tag_links(tags)
    tags.split(",").map{ |tag| link_to tag, tag_path(tag)}.join(", ")
  end
end
