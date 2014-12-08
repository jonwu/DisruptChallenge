################################## Questions ###################################
user = User.create(     email: 'ibm@ibm.com',
                        name: "IBM", 
                        password: 'password',
                        password_confirmation: 'password')

user2 = User.create(    email: 'oracle@oracle.com',
                        name: "Oracle",
                        password: 'password',
                        password_confirmation: 'password')

user3 = User.create(    email: 'google@google.com',
                        name: "Google",
                        password: 'password',
                        password_confirmation: 'password')

user4 = User.create(    email: 'sap@sap.com',
                        name: "SAP",
                        password: 'password',
                        password_confirmation: 'password')

user5 = User.create(    email: 'vmware@vmware.com',
                        name: "VMware",
                        password: 'password',
                        password_confirmation: 'password')

user6 = User.create(    email: 'amazon@amazon.com',
                        name: "Amazon",
                        password: 'password',
                        password_confirmation: 'password')

user7 = User.create(    email: 'microsoft@microsoft.com',
                        name: "Microsoft",
                        password: 'password',
                        password_confirmation: 'password')

user8 = User.create(    email: 'anna@anna.com',
                        name: "Anna",
                        password: 'password',
                        password_confirmation: 'password')


rfi = Rfi.create( user_id: user8.id,
                  title: "Big Data Solution")

collab = Collaborator.create( user_id: user.id,
                              rfi_id: rfi.id)
collab2 = Collaborator.create( user_id: user2.id,
                              rfi_id: rfi.id)
collab3 = Collaborator.create( user_id: user3.id,
                              rfi_id: rfi.id)
collab4 = Collaborator.create( user_id: user4.id,
                              rfi_id: rfi.id)
collab5 = Collaborator.create( user_id: user5.id,
                              rfi_id: rfi.id)
collab6 = Collaborator.create( user_id: user6.id,
                              rfi_id: rfi.id)
collab7 = Collaborator.create( user_id: user7.id,
                              rfi_id: rfi.id)

category = Category.create(   rfi_id: rfi.id,
                              text: "Technical")
category2 = Category.create(   rfi_id: rfi.id,
                              text: "Security")
category3 = Category.create(   rfi_id: rfi.id,
                              text: "Management")
category4 = Category.create(   rfi_id: rfi.id,
                              text: "Costs")

q0 = Question.create(  category_id: category.id,
                  qual: true,
                  quant: false,
                  text: "What services do you provide?",
                  impact: "High")

q1 = Question.create(  category_id: category.id,
                  qual: true,
                  quant: false,
                  text: "Which operating systems are compatible with this product?",
                  impact: "Medium")

q2 = Question.create(  category_id: category.id,
                  qual: false,
                  quant: true,
                  text: "What server software is compatible with this product?",
                  impact: "Medium")

q3 = Question.create(  category_id: category.id,
                  qual: true,
                  quant: true,
                  text: "Can this product work effectively on a multi-platform network?",
                  impact: "High")

q4 = Question.create(  category_id: category.id,
                  qual: true,
                  quant: false,
                  text: "Beyond typical network or desktop equipment, what additional hardware is needed for optimal operation of this product?",
                  impact: "High")

q5 = Question.create(  category_id: category.id,
                  qual: true, 
                  quant: false,
                  text: "How does this product work with hardware and software based security applications?",
                  impact: "Low")

q6 = Question.create(  category_id: category.id,
                  qual: true,
                  quant: false,
                  text: "Are there special network requirements (LAN or WAN) for optimal operation of this product?",
                  impact: "Medium")

q7 = Question.create(  category_id: category.id,
                  qual: true, 
                  quant: false,
                  text: "What is the minimum processing speed required for optimal operation of this product?",
                  impact: "High")

q8 = Question.create(  category_id: category.id,
                  qual: true,
                  quant: false,
                  text: "Does this product have any known conflicts or incompatibilities with any software or hardware (including firewall products)?  If so, describe.",
                  impact: "High")

# Question 0 responses - for video rating - defaults to first question.
Response.create(  question_id: q0.id,
                  user_id: user2.id,
                  text: "Our flagship and revolutionary solution -- Oracle Big Data SQL -- integrates Hadoop, NoSQL, and Oracle Database. 
                  Our data analytics engine can turn your customer interactions into bigger opportunities, while our data management and integration systems ensure your company has performance, scalability, and reliability even in the cloud.")
Response.create(  question_id: q0.id,
                  user_id: user.id,
                  text: "We provide server and storage hardware, database software, analytics applications and IT management.")
Response.create(  question_id: q0.id,
                  user_id: user3.id,
                  text: "Our solution for you is BigQuery, a cloud-based Big Data analytics platform. By using familiar SQL-like queries, our engine will return results in seconds even with multi-terabyte datasets.")
Response.create(  question_id: q0.id,
                  user_id: user4.id,
                  text: "Our Big Data analytics system, powered by our trademark SAP HANA database solution, will simplify your IT infrastructure and assist your business quickly identify risks and opportunities. Our expert data scientists will help extract maximum value in all of your data.")
Response.create(  question_id: q0.id,
                  user_id: user5.id,
                  text: "After launching vSphere Big Data Extensions, virtualization of Hadoop deployments for your business's big data needs becomes possible. Our solution provides elastic scaling of Hadoop clusters that is promised to be secure and reliable.")
Response.create(  question_id: q0.id,
                  user_id: user6.id,
                  text: "We provide a cloud-based big data platform called Amazon Elastic MapReduce, a platform available on AWS. We also offer a number of other big data products, like DynamoDB for storage of information, and Redshift to extract useful trends affordably and reliably.")
Response.create(  question_id: q0.id,
                  user_id: user7.id,
                  text: "Our solution is Azure HDInsight, a big data solution powered by Hadoop. It allows enterprises to quickly launch appropriately sized Hadoop clusters for any computational task. Our partnership with Hortonworks allows for platform flexibility,
                  a unique quality in the industry.")

# Google's all technical responses - for video responses in first category
Response.create(  question_id: q1.id,
                  user_id: user3.id,
                  text: "Currently, we provide support on the three most popular operating systems, Windows, Mac OSX, and Linux.")
Response.create(  question_id: q2.id,
                  user_id: user3.id,
                  text: "With the support of many third-party partners, we support a range of server side applications, including visualization and business intelligence tools.")
Response.create(  question_id: q3.id,
                  user_id: user3.id,
                  text: "Definitely! We work very hard to ensure our system is compatible with a range of business infrastructure and integration as simple and painless as possible.")
Response.create(  question_id: q4.id,
                  user_id: user3.id,
                  text: "None! BigQuery can be utilized through a browser tool or the command-line to make calls to the REST API using a variety of languages, whichever your business supports best. In terms of hardware, the heavy lifting is done on our end.")
Response.create(  question_id: q5.id,
                  user_id: user3.id,
                  text: "Our product mimimizes impact to your security applications by having your data moved to BigQuery before handling the heavy processing. We guarantee only the most secure processing of your information.")
Response.create(  question_id: q6.id,
                  user_id: user3.id,
                  text: "All we require a simple network connection on your end to send us your data and allows us to return the answer to your queries.")
Response.create(  question_id: q7.id,
                  user_id: user3.id,
                  text: "As long as there is a working browser on your end, there are no additional processing speed requirements. Our infrastructure takes care of the heavy processing requirements.")
Response.create(  question_id: q8.id,
                  user_id: user3.id,
                  text: "None that are currently known.")

# ibm responses 
Response.create(  question_id: q1.id,
                  user_id: user.id,
                  text: "a")
Response.create(  question_id: q2.id,
                  user_id: user.id,
                  text: "a")
Response.create(  question_id: q3.id,
                  user_id: user.id,
                  text: "a")
Response.create(  question_id: q4.id,
                  user_id: user.id,
                  text: "a")
Response.create(  question_id: q5.id,
                  user_id: user.id,
                  text: "a")
Response.create(  question_id: q6.id,
                  user_id: user.id,
                  text: "a")
Response.create(  question_id: q7.id,
                  user_id: user.id,
                  text: "a")
Response.create(  question_id: q8.id,
                  user_id: user.id,
                  text: "a")

# oracle responses 
Response.create(  question_id: q1.id,
                  user_id: user2.id,
                  text: "a")
Response.create(  question_id: q2.id,
                  user_id: user2.id,
                  text: "a")
Response.create(  question_id: q3.id,
                  user_id: user2.id,
                  text: "a")
Response.create(  question_id: q4.id,
                  user_id: user2.id,
                  text: "a")
Response.create(  question_id: q5.id,
                  user_id: user2.id,
                  text: "a")
Response.create(  question_id: q6.id,
                  user_id: user2.id,
                  text: "a")
Response.create(  question_id: q7.id,
                  user_id: user2.id,
                  text: "a")
Response.create(  question_id: q8.id,
                  user_id: user2.id,
                  text: "a")

# SAP responses 
Response.create(  question_id: q1.id,
                  user_id: user3.id,
                  text: "a")
Response.create(  question_id: q2.id,
                  user_id: user3.id,
                  text: "a")
Response.create(  question_id: q3.id,
                  user_id: user3.id,
                  text: "a")
Response.create(  question_id: q4.id,
                  user_id: user3.id,
                  text: "a")
Response.create(  question_id: q5.id,
                  user_id: user3.id,
                  text: "a")
Response.create(  question_id: q6.id,
                  user_id: user3.id,
                  text: "a")
Response.create(  question_id: q7.id,
                  user_id: user3.id,
                  text: "a")
Response.create(  question_id: q8.id,
                  user_id: user3.id,
                  text: "a")

# SAP responses 
Response.create(  question_id: q1.id,
                  user_id: user4.id,
                  text: "a")
Response.create(  question_id: q2.id,
                  user_id: user4.id,
                  text: "a")
Response.create(  question_id: q3.id,
                  user_id: user4.id,
                  text: "a")
Response.create(  question_id: q4.id,
                  user_id: user4.id,
                  text: "a")
Response.create(  question_id: q5.id,
                  user_id: user4.id,
                  text: "a")
Response.create(  question_id: q6.id,
                  user_id: user4.id,
                  text: "a")
Response.create(  question_id: q7.id,
                  user_id: user4.id,
                  text: "a")
Response.create(  question_id: q8.id,
                  user_id: user4.id,
                  text: "a")

# VMWare responses 
Response.create(  question_id: q1.id,
                  user_id: user5.id,
                  text: "a")
Response.create(  question_id: q2.id,
                  user_id: user5.id,
                  text: "a")
Response.create(  question_id: q3.id,
                  user_id: user5.id,
                  text: "a")
Response.create(  question_id: q4.id,
                  user_id: user5.id,
                  text: "a")
Response.create(  question_id: q5.id,
                  user_id: user5.id,
                  text: "a")
Response.create(  question_id: q6.id,
                  user_id: user5.id,
                  text: "a")
Response.create(  question_id: q7.id,
                  user_id: user5.id,
                  text: "a")
Response.create(  question_id: q8.id,
                  user_id: user5.id,
                  text: "a")


# Amazon responses 
Response.create(  question_id: q1.id,
                  user_id: user6.id,
                  text: "a")
Response.create(  question_id: q2.id,
                  user_id: user6.id,
                  text: "a")
Response.create(  question_id: q3.id,
                  user_id: user6.id,
                  text: "a")
Response.create(  question_id: q4.id,
                  user_id: user6.id,
                  text: "a")
Response.create(  question_id: q5.id,
                  user_id: user6.id,
                  text: "a")
Response.create(  question_id: q6.id,
                  user_id: user6.id,
                  text: "a")
Response.create(  question_id: q7.id,
                  user_id: user6.id,
                  text: "a")
Response.create(  question_id: q8.id,
                  user_id: user6.id,
                  text: "a")


# Microsoft responses 
Response.create(  question_id: q1.id,
                  user_id: user7.id,
                  text: "a")
Response.create(  question_id: q2.id,
                  user_id: user7.id,
                  text: "a")
Response.create(  question_id: q3.id,
                  user_id: user7.id,
                  text: "a")
Response.create(  question_id: q4.id,
                  user_id: user7.id,
                  text: "a")
Response.create(  question_id: q5.id,
                  user_id: user7.id,
                  text: "a")
Response.create(  question_id: q6.id,
                  user_id: user7.id,
                  text: "a")
Response.create(  question_id: q7.id,
                  user_id: user7.id,
                  text: "a")
Response.create(  question_id: q8.id,
                  user_id: user7.id,
                  text: "a")

# Response.create(  question_id: q1.id,
#                   user_id: user3.id,
#                   text: "Just a few things.")
# Response.create(  question_id: q2.id,
#                   user_id: user3.id,
#                   text: "Nope.")
# Response.create(  question_id: q3.id,
#                   user_id: user3.id,
#                   text: "No.")
# Response.create(  question_id: q4.id,
#                   user_id: user3.id,
#                   text: "Unfortunately, no.")
# Response.create(  question_id: q5.id,
#                   user_id: user3.id,
#                   text: "10!")
# Response.create(  question_id: q6.id,
#                   user_id: user3.id,
#                   text: "Uhh....sometimes.")
# Response.create(  question_id: q7.id,
#                   user_id: user3.id,
#                   text: "Honestly, just myself.")
# Response.create(  question_id: q8.id,
#                   user_id: user3.id,
#                   text: "Brute force.")
# Response.create(  question_id: q9.id,
#                   user_id: user3.id,
#                   text: "Exponential?")
# Response.create(  question_id: q10.id,
#                   user_id: user3.id,
#                   text: "If the word does not match exactly, remove the result.")


