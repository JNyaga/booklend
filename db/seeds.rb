# Clear existing records
Book.destroy_all

# Example books with real data
books = [
  {
    title: "The Pragmatic Programmer",
    author: "Andrew Hunt, David Thomas",
    first_publish_year: 1999,
    isbn: "978-0201616224",
    is_available: true,
    image_url: "https://images-na.ssl-images-amazon.com/images/I/41as+WafrFL._SX378_BO1,204,203,200_.jpg",
    description: "A guide to pragmatic software development, filled with practical advice and real-world examples."
  },
  {
    title: "Refactoring: Improving the Design of Existing Code",
    author: "Martin Fowler",
    first_publish_year: 1999,
    isbn: "978-0201485677",
    is_available: true,
    image_url: "https://images-na.ssl-images-amazon.com/images/I/41odjJlPgHL._SX378_BO1,204,203,200_.jpg",
    description: "Classic reference on refactoring techniques for improving existing code bases."
  },
  {
    title: "You Don't Know JS: Up & Going",
    author: "Kyle Simpson",
    first_publish_year: 2015,
    isbn: "978-1491924464",
    is_available: false,
    image_url: "https://images-na.ssl-images-amazon.com/images/I/410%2BtmN-P%2BL._SX331_BO1,204,203,200_.jpg",
    description: "First book in the YDKJS series introducing JavaScript programming fundamentals."
  },
  {
    title: "Code Complete: A Practical Handbook of Software Construction",
    author: "Steve McConnell",
    first_publish_year: 1993,
    isbn: "978-0735619678",
    is_available: true,
    image_url: "https://placehold.co/300x450?text=Book+Cover",
    description: "Comprehensive guide to software construction with practical checklists and best practices."
  },
  {
    title: "The Clean Coder: A Code of Conduct for Professional Programmers",
    author: "Robert C. Martin",
    first_publish_year: 2011,
    isbn: "978-0137081073",
    is_available: true,
    image_url: "https://placehold.co/300x450?text=Book+Cover",
    description: "Practical advice for professional software developers about attitudes and approaches."
  },
  {
    title: "Effective Java",
    author: "Joshua Bloch",
    first_publish_year: 2001,
    isbn: "978-0134685991",
    is_available: true,
    image_url: "https://placehold.co/300x450?text=Book+Cover",
    description: "Essential Java programming best practices with updated coverage through Java 9."
  },
  {
    title: "Structure and Interpretation of Computer Programs",
    author: "Harold Abelson, Gerald Jay Sussman, Julie Sussman",
    first_publish_year: 1984,
    isbn: "978-0262510875",
    is_available: false,
    image_url: "https://placehold.co/300x450?text=Book+Cover",
    description: "Classic computer science text using Scheme to explain fundamental programming concepts."
  },
  {
    title: "JavaScript: The Good Parts",
    author: "Douglas Crockford",
    first_publish_year: 2008,
    isbn: "978-0596517748",
    is_available: true,
    image_url: "https://images-na.ssl-images-amazon.com/images/I/81kqrwS1nNL._SY342_.jpg",
    description: "Essential guide to JavaScript's best features and most reliable programming techniques."
  },
  {
    title: "Domain-Driven Design: Tackling Complexity in the Heart of Software",
    author: "Eric Evans",
    first_publish_year: 2003,
    isbn: "978-0321125217",
    is_available: true,
    image_url: "https://images-na.ssl-images-amazon.com/images/I/51sZW87slRL._SX331_BO1,204,203,200_.jpg",
    description: "Fundamental text on domain-driven design approaches for complex software systems."
  },
  {
    title: "The Mythical Man-Month: Essays on Software Engineering",
    author: "Fred Brooks",
    first_publish_year: 1975,
    isbn: "978-0201835953",
    is_available: false,
    image_url: "https://placehold.co/300x450?text=Book+Cover",
    description: "Seminal essays on software engineering and project management, still relevant today."
  },
  {
    title: "Cracking the Coding Interview: 189 Programming Questions and Solutions",
    author: "Gayle Laakmann McDowell",
    first_publish_year: 2008,
    isbn: "978-0984782857",
    is_available: true,
    image_url: "https://images-na.ssl-images-amazon.com/images/I/41oYsXjLvZL._SY344_BO1,204,203,200_.jpg",
    description: "Comprehensive guide to technical interview preparation with coding problems and solutions."
  },
  {
    title: "Introduction to Algorithms",
    author: "Thomas H. Cormen, Charles E. Leiserson, Ronald L. Rivest, Clifford Stein",
    first_publish_year: 1990,
    isbn: "978-0262033848",
    is_available: true,
    image_url: "https://placehold.co/300x450?text=Book+Cover",
    description: "Comprehensive textbook covering a broad range of algorithms in depth."
  },
  {
    title: "Working Effectively with Legacy Code",
    author: "Michael Feathers",
    first_publish_year: 2004,
    isbn: "978-0131177055",
    is_available: false,
    image_url: "https://placehold.co/300x450?text=Book+Cover",
    description: "Practical strategies for working with and improving existing codebases."
  },
  {
    title: "Don't Make Me Think: A Common Sense Approach to Web Usability",
    author: "Steve Krug",
    first_publish_year: 2000,
    isbn: "978-0321344755",
    is_available: true,
    image_url: "https://placehold.co/300x450?text=Book+Cover",
    description: "Classic guide to web usability and intuitive interface design."
  },
  {
    title: "The Art of Computer Programming",
    author: "Donald E. Knuth",
    first_publish_year: 1968,
    isbn: "978-0321751041",
    is_available: true,
    image_url: "https://images-na.ssl-images-amazon.com/images/I/41msKv2oN9L._SX398_BO1,204,203,200_.jpg",
    description: "Monumental work covering fundamental algorithms and their analysis."
  },
  {
    title: "Head First Design Patterns: A Brain-Friendly Guide",
    author: "Eric Freeman, Elisabeth Robson",
    first_publish_year: 2004,
    isbn: "978-0596007126",
    is_available: true,
    image_url: "https://images-na.ssl-images-amazon.com/images/I/61APhXCksuL._SX430_BO1,204,203,200_.jpg",
    description: "Engaging introduction to design patterns using visual methods and practical examples."
  },
  {
    title: "The DevOps Handbook: How to Create World-Class Agility, Reliability, & Security in Technology Organizations",
    author: "Gene Kim, Jez Humble, Patrick Debois, John Willis",
    first_publish_year: 2016,
    isbn: "978-1942788003",
    is_available: false,
    image_url: "https://placehold.co/300x450?text=Book+Cover",
    description: "Practical guide to implementing DevOps principles in organizations."
  },
  {
    title: "Site Reliability Engineering: How Google Runs Production Systems",
    author: "Betsy Beyer, Chris Jones, Jennifer Petoff, Niall Richard Murphy",
    first_publish_year: 2016,
    isbn: "978-1491929124",
    is_available: true,
    image_url: "https://placehold.co/300x450?text=Book+Cover",
    description: "Insights into Google's approach to building and maintaining reliable systems."
  }
]

# Insert into the database
books.each do |book|
  Book.create!(book)
end

puts "✅ Seeded #{Book.count} books successfully!"
