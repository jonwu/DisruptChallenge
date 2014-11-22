################################## Questions ###################################
user = User.create(     email: 'howardg988@gmail.com', 
                        password: 'password',
                        password_confirmation: 'password')

user2 = User.create(    email: 'howardg988@berkeley.edu',
                        password: 'password',
                        password_confirmation: 'password')

user3 = User.create(    email: 'jonwu92@berkeley.edu',
                        password: 'password',
                        password_confirmation: 'password')

rfi = Rfi.create( user_id: user.id,
                  title: "test")

collab = Collaborator.create( user_id: user.id,
                              rfi_id: rfi.id)
collab2 = Collaborator.create( user_id: user2.id,
                              rfi_id: rfi.id)
collab3 = Collaborator.create( user_id: user3.id,
                              rfi_id: rfi.id)

category = Category.create(   rfi_id: rfi.id,
                              text: "Technology")
category2 = Category.create(   rfi_id: rfi.id,
                              text: "Scalability")
category3 = Category.create(   rfi_id: rfi.id,
                              text: "Efficiency")

q1 = Question.create(  category_id: category.id,
                  qual: true,
                  quant: false,
                  text: "What features does your technology provide?",
                  impact: "High")

q2 = Question.create(  category_id: category.id,
                  qual: false,
                  quant: true,
                  text: "Can your technology do X?",
                  impact: "Medium")

q3 = Question.create(  category_id: category.id,
                  qual: true,
                  quant: true,
                  text: "Can your technology do Y? If so, explain.",
                  impact: "Medium")

q4 = Question.create(  category_id: category.id,
                  qual: true,
                  quant: false,
                  text: "Does your software support relational databases?",
                  impact: "High")

q5 = Question.create(  category_id: category2.id,
                  qual: true, 
                  quant: false,
                  text: "How many servers do you have?",
                  impact: "Medium")

q6 = Question.create(  category_id: category2.id,
                  qual: true,
                  quant: false,
                  text: "How often does your software crash and burn?",
                  impact: "High")

q7 = Question.create(  category_id: category2.id,
                  qual: true,
                  quant: false,
                  text: "What is the maximum number of customers for which your services can sustain?",
                  impact: "High")
q8 = Question.create(  category_id: category3.id,
                  qual: true, 
                  quant: false,
                  text: "What algorithm do you use to join database tables?",
                  impact: "Medium")

q9 = Question.create(  category_id: category3.id,
                  qual: true,
                  quant: false,
                  text: "What is the running time for your path finding algorithm?",
                  impact: "High")

q10 = Question.create(  category_id: category3.id,
                  qual: true,
                  quant: false,
                  text: "Explain the strategies for how to prune your search results.",
                  impact: "Medium")

Response.create(  question_id: q1.id,
                  user_id: user.id,
                  text: "The world is the limit.")
Response.create(  question_id: q2.id,
                  user_id: user.id,
                  text: "Yes, I do!")
Response.create(  question_id: q3.id,
                  user_id: user.id,
                  text: "Yes. Just yes.")
Response.create(  question_id: q4.id,
                  user_id: user.id,
                  text: "Yes.")
Response.create(  question_id: q5.id,
                  user_id: user.id,
                  text: "500 thousand.")
Response.create(  question_id: q6.id,
                  user_id: user.id,
                  text: "Once in a while.")
Response.create(  question_id: q7.id,
                  user_id: user.id,
                  text: "100 thousand concurrent users.")
Response.create(  question_id: q8.id,
                  user_id: user.id,
                  text: "Nested Blocked Join")
Response.create(  question_id: q9.id,
                  user_id: user.id,
                  text: "Worst case linear")
Response.create(  question_id: q10.id,
                  user_id: user.id,
                  text: "We use Google's algorithm.")

Response.create(  question_id: q1.id,
                  user_id: user2.id,
                  text: "Everything")
Response.create(  question_id: q2.id,
                  user_id: user2.id,
                  text: "Of course!")
Response.create(  question_id: q3.id,
                  user_id: user2.id,
                  text: "Need I explain more?")
Response.create(  question_id: q4.id,
                  user_id: user2.id,
                  text: "Yes")
Response.create(  question_id: q5.id,
                  user_id: user2.id,
                  text: "1 million")
Response.create(  question_id: q6.id,
                  user_id: user2.id,
                  text: "Never")
Response.create(  question_id: q7.id,
                  user_id: user2.id,
                  text: "10 million")
Response.create(  question_id: q8.id,
                  user_id: user2.id,
                  text: "Leapfrog Triejoin")
Response.create(  question_id: q9.id,
                  user_id: user2.id,
                  text: "Linear")
Response.create(  question_id: q10.id,
                  user_id: user2.id,
                  text: "None. Search results are instantaneous.")

Response.create(  question_id: q1.id,
                  user_id: user3.id,
                  text: "Just a few things.")
Response.create(  question_id: q2.id,
                  user_id: user3.id,
                  text: "Nope.")
Response.create(  question_id: q3.id,
                  user_id: user3.id,
                  text: "No.")
Response.create(  question_id: q4.id,
                  user_id: user3.id,
                  text: "Unfortunately, no.")
Response.create(  question_id: q5.id,
                  user_id: user3.id,
                  text: "10!")
Response.create(  question_id: q6.id,
                  user_id: user3.id,
                  text: "Uhh....sometimes.")
Response.create(  question_id: q7.id,
                  user_id: user3.id,
                  text: "Honestly, just myself.")
Response.create(  question_id: q8.id,
                  user_id: user3.id,
                  text: "Brute force.")
Response.create(  question_id: q9.id,
                  user_id: user3.id,
                  text: "Exponential?")
Response.create(  question_id: q10.id,
                  user_id: user3.id,
                  text: "If the word does not match exactly, remove the result.")


