json.array!(@blogs) do |blog|
  json.extract! blog, :id, :title, :content, :picture
  json.url blog_url(blog, format: :json)
end
