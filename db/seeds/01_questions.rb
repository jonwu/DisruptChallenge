################################## Questions ###################################

rfi = Rfi.create!

Question.create(  rfi_id: rfi.id,
                  qual: true, 
                  quant: false,
                  category: "",
                  text: "List your contact information.")

Question.create(  rfi_id: rfi.id,
                  qual: true,
                  quant: false,
                  category: "",
                  text: "What features does your technology provide?")

Question.create(  rfi_id: rfi.id,
                  qual: false,
                  quant: true,
                  category: "",
                  text: "Can your technology do X?")

Question.create(  rfi_id: rfi.id,
                  qual: true,
                  quant: true,
                  category: "",
                  text: "Can your technology do Y? If so, explain.")

Question.create(  rfi_id: rfi.id,
                  qual: true,
                  quant: true,
                  category: "",
                  text: "Does your software support relational databases?")