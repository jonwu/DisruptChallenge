################################## Questions ###################################
user = User.create(     email: 'howardg988@gmail.com', 
                        password: 'password',
                        password_confirmation: 'password')

user2 = User.create(    email: 'howardg988@berkeley.edu',
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

Question.create(  category_id: category.id,
                  qual: true, 
                  quant: false,
                  text: "List your contact information.",
                  impact: "Low")

Question.create(  category_id: category.id,
                  qual: true,
                  quant: false,
                  text: "What features does your technology provide?",
                  impact: "High")

Question.create(  category_id: category.id,
                  qual: false,
                  quant: true,
                  text: "Can your technology do X?",
                  impact: "Medium")

Question.create(  category_id: category.id,
                  qual: true,
                  quant: true,
                  text: "Can your technology do Y? If so, explain.",
                  impact: "Medium")

Question.create(  category_id: category.id,
                  qual: true,
                  quant: false,
                  text: "Does your software support relational databases?",
                  impact: "High")

Question.create(  category_id: category2.id,
                  qual: true,
                  quant: false,
                  text: "How awesome is this category?",
                  impact: "High")

Question.create(  category_id: category2.id,
                  qual: true,
                  quant: false,
                  text: "How high does this category rank for you?",
                  impact: "Medium")
