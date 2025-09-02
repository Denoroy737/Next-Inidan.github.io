console.log("Hey! I Got The Index.js File")

// Initialize the news api parameters
let source = 'the-times-of-india';
let apiKey = 'b063b81b251e46279fb896f84b440'

// Grab the news container
let newsAccordion = document.getElementById("newsAccordion")

// Create an ajax get request
const xhr = new XMLHttpRequest()
xhr.open('GET', `https://newsapi.org/v2/top-headlines?country=in&category=technology&apiKey=${apiKey}`, true);

// What to do when response is ready
xhr.onload = function (){
    if(this.status === 200){
        let json = JSON.parse(this.responseText)
        let articles = json.articles
        // console.log(articles)
        let newsHtml = ""
        articles.forEach(function(element){
            //  console.log(element)
            let news = `<div class="py-7 my-2 flex flex-wrap md:flex-nowrap rounded-2xl shadow-xl bg-gray-200">
            <div class="md:w-64 md:mb-0 mb-6 flex-shrink-0 flex flex-col px-5  ">
              <img class="rounded-md" src="${element["urlToImage"]}" alt="" srcset="">
            </div>
            <div class="md:flex-grow">
            <a href="${element["url"]}"><h2 class="text-2xl font-medium text-gray-900 title-font mb-2 hover:text-gray-700">${element["title"]}</h2></a>
              <p class="leading-relaxed">${element["description"]}</p>
              <a class="text-indigo-500 inline-flex items-center mt-4" href="${element["url"]}">Learn More
                <svg class="w-4 h-4 ml-2" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round">
                  <path d="M5 12h14"></path>
                  <path d="M12 5l7 7-7 7"></path>
                </svg>
              </a>
            </div>
          </div>
          <hr>`;
          newsHtml += news;
        });
        newsAccordion.innerHTML = newsHtml;
    }
    else{
        console.log("something went wrong, please try again")
    }
}


xhr.send()
