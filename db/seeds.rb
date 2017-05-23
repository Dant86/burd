foo = User.create(first_name: "Vedant", last_name: "Pathak", username: "dant", profile_pic_url: "24762384716452.com")
foo.password="foo"

bar = User.create(first_name: "Eden", last_name: "Hazard", username: "hazard10", profile_pic_url: "adfsfdgfdfgdf.jpg")
bar.password="bar"

50.times do 
	Post.create(post_img_url: "", post_body: "This is a post", user_id: 1)
end

Like.create(post_id: 1, user_id: 2)

Comment.create()