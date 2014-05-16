
###1: 创建一个应用程序
```
mkdir projects
cd projects
rails new myblog
rails s
```

在浏览器中打开 http://localhost:3000
在控制台中键入CTRL-C 可以退出服务。
解释每一步指令的含义，以及我们刚刚生成了什么（哪些文件）？ Rails服务是做什么用的？

```
git init
...
```
做一次git提交。


###2: 创建一个名为blog的Scaffold

我们使用Rails的scaffold来创建一个模板，在此基础上我们可以对数据进行列出、加入、删除、修改和预览等操作，这里的数据指的是我们的blog

```
rails generate scaffold blog title:string content:text picture:string
rake db:migrate
rails s
```
在浏览器中打开 http://localhost:3000/blogs

教练: 什么是scaffold，什么是migration。

做一次git提交。

###3: 添加图片上传功能

为了实现图片上传功能我们需要安装额外的库（libraries）。

打开文件 Gemfile 并找到这一行
```
gem 'sqlite3'
```
在它下面添加
```
gem 'carrierwave'
```
教练: 请解释什么是库(libraries)以及为什么需要使用它们。不妨也聊聊开源？

现在我们来生成主管图片上传的代码，打开控制台并键入：
```
bundle
rails generate uploader Picture
```
打开 app/models/blog.rb 找到这一行：
```
class Blog < ActiveRecord::Base
```
并在其下方添加：
```
mount_uploader :picture, PictureUploader
```
打开 app/views/ideas/_form.html.erb ，找到这一行：
```
<%= f.text_field :picture %>
```
将它改成：
```
<%= f.file_field :picture %>
```
并将这一行：
```
<%= form_for(@blog) do |f| %>
```
改成：
```
<%= form_for(@blog, :html => {:multipart => true}) do |f| %>
```
启动服务，看一下有什么变化。我们的view还是不够耐看，因为它只显示文件路径。我们可以这么改进：

打开 app/views/ideas/show.html.erb 并将
```
<%= @idea.picture %>
```
改为
```
<%= image_tag(@blog.picture_url, :width => 600) if @blog.picture.present? %>
```

打开 app/views/ideas/index.html.erb 并将
```
<td><%= blog.picture %></td>
```
改为
```
<td><%= image_tag(blog.picture_url, :width => 600) if blog.picture.present? %></td>
```
教练: 聊聊HTML。

###4: 微调路径（Routes）

如果你试图打开 http://localhost:3000 看到的还是默认的页面，我们需要把它重定向到blogs页面。

在 OS X 或 Linux 下，在控制台下运行:
```
rm public/index.html
```
在 Windows 下，在控制台下运行：
```
del public\index.html
```
然后打开 config/routes.rb 并在第二行加入以下代码：

root :to => redirect("/blogs")
教练: 请谈谈Routes。

###5: 设计

网页的外观设计还有待我们动手改进。用Twitter的Bootstrap项目，我们可以轻松的生成网页的stylesheet

打开app/views/layouts/application.html.erb 找到这一行
```
<%= stylesheet_link_tag "application" %>
```
并在它上面加入以下代码
```
<link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css">
```

然后把
```
<%= yield %>
```
换成
```
<div class="container">
    <%= yield %>
    </div>
    ```

    现在我们给博客添加导航栏。

    找到这个文件 application.html.erb，在<body>下添加：
    ```
    <nav class="navbar navbar-default navbar-static-top" role="navigation">
      <div class="container">
          <ul class="nav navbar-nav">
	        <li class="active"><a href="#">Myblog</a></li>
		      <li><a href="#">About me</a></li>
		          </ul>
			    </div>
			    </nav>
			    ```
