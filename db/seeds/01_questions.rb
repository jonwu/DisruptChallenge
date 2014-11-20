################################## Questions ###################################
user = User.create(     email: 'howardg988@gmail.com', 
                        password: 'password',
                        password_confirmation: 'password')

user2 = User.create(    email: 'howardg988@berkeley.edu',
                        password: 'password',
                        password_confirmation: 'password')

user3 = User.create(    email: 'jonwu@berkeley.edu',
                        password: 'password',
                        password_confirmation: 'password')

rfi = Rfi.create( user_id: user.id,
                  title: "test")

collab = Collaborator.create( user_id: user2.id,
                              rfi_id: rfi.id)

category = Category.create(   rfi_id: rfi.id,
                              text: "default")
category2 = Category.create(   rfi_id: rfi.id,
                              text: "awesome")

q1 = Question.create(  category_id: category.id,
                  qual: true, 
                  quant: false,
                  text: "List your contact information.",
                  impact: "Low")

q2 = Question.create(  category_id: category.id,
                  qual: true,
                  quant: false,
                  text: "What features does your technology provide?",
                  impact: "High")

q3 = Question.create(  category_id: category.id,
                  qual: false,
                  quant: true,
                  text: "Can your technology do X?",
                  impact: "Medium")

q4 = Question.create(  category_id: category.id,
                  qual: true,
                  quant: true,
                  text: "Can your technology do Y? If so, explain.",
                  impact: "Medium")

q5 = Question.create(  category_id: category.id,
                  qual: true,
                  quant: false,
                  text: "Does your software support relational databases?",
                  impact: "High")

q6 = Question.create(  category_id: category2.id,
                  qual: true,
                  quant: false,
                  text: "How awesome is this category?",
                  impact: "High")

q7 = Question.create(  category_id: category2.id,
                  qual: true,
                  quant: false,
                  text: "How high does this category rank for you?",
                  impact: "Medium")

Response.create(  question_id: q1.id,
                  user_id: user2.id,
                  text: "Berkeley")
Response.create(  question_id: q2.id,
                  user_id: user2.id,
                  text: "Everything")
Response.create(  question_id: q3.id,
                  user_id: user2.id,
                  text: "Of course!")
Response.create(  question_id: q4.id,
                  user_id: user2.id)
Response.create(  question_id: q5.id,
                  user_id: user2.id)
Response.create(  question_id: q6.id,
                  user_id: user2.id)
Response.create(  question_id: q7.id,
                  user_id: user2.id)

Response.create(  question_id: q1.id,
                  user_id: user3.id,
                  text: "Union City")
Response.create(  question_id: q2.id,
                  user_id: user3.id,
                  text: "Nothing")
Response.create(  question_id: q3.id,
                  user_id: user3.id,
                  text: "Nope")
