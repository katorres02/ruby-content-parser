# INDEX CONTENT WITH RUBY

This is an example of indexing html content using Ruby on Rails and [nokogiri gem](https://github.com/sparklemotion/nokogiri).

### Installation
* Clone the repository `git clone https://github.com/katorres02/ruby-content-parser`
* Install gems `bundle install`
* Create database `rake db:create db:migrate`
* Run tests `bin/rake`
* Run server `rails s`

### Web Usage
You can see a live [Demo here](https://rocky-shelf-60680.herokuapp.com/).

Every url indexed with the api is stored in a database. You can see this information in the web dashboard or you can call one of the api endpoints for this.

* Indexed Urls dashboard: 
![alt text](https://raw.githubusercontent.com/katorres02/ruby-content-parser/master/app/assets/images/index.png "Dashboard")

* Content stored for url: 
![alt text](https://raw.githubusercontent.com/katorres02/ruby-content-parser/master/app/assets/images/show.png "details")


### API Usage

There is a resource called "page" that contains 2 webservices. One for search, index and store information of an specific html tag and the other for retrieve stored information for one url.

* `POST http://HOST_URL/api/v1/pages`
  Index content from an url.
#### Request

| Name        | Description           | Example  |
| ------------- |:-------------:| -----:|
| url      | Target url you want to index | https://github.com/sparklemotion/nokogiri |
| tags      | Tag or Tags you want to search, in case you want more tha one you can separate them by commas |   h1,h2,h3,a |

#### Response

| Name        | Description           |
| ------------- |:-------------:|
| id      | Database uniq identifier |
| url      | Url scanned |
| stored_tags      | array of indexed tags |
| stored_elements      | array of Elements for each tag |
| stored_elements[id]      |Element database uniq identifier |
| stored_elements[tag]      |Element html tag that belongs |
| stored_elements[html]      |Element string inside the html tag, this contains html code |
| stored_elements[content]      |Element string visible by users. This is the text that a normal user can see in the page|
| stored_elements[href]      |Element href url. Only for links (a)|

#### Example
##### Request example
`POST http://HOST_URL/api/v1/pages`

params
```json
{ "url": "https://github.com/sparklemotion/nokogiri", "tags": "h1" }
```
##### Response example
```json
{
    "page": {
        "id": 1,
        "url": "https://github.com/sparklemotion/nokogiri",
        "stored_elements": [
            {
                "stored_element": {
                    "id": 1,
                    "tag": "h1",
                    "html": "<h1 class=\"public \">\n  <svg aria-hidden=\"true\" class=\"octicon octicon-repo\" height=\"16\" version=\"1.1\" viewbox=\"0 0 12 16\" width=\"12\"><path fill-rule=\"evenodd\" d=\"M4 9H3V8h1v1zm0-3H3v1h1V6zm0-2H3v1h1V4zm0-2H3v1h1V2zm8-1v12c0 .55-.45 1-1 1H6v2l-1.5-1.5L3 16v-2H1c-.55 0-1-.45-1-1V1c0-.55.45-1 1-1h10c.55 0 1 .45 1 1zm-1 10H1v2h2v-1h3v1h5v-2zm0-10H2v9h9V1z\"></path></svg>\n  <span class=\"author\" itemprop=\"author\"><a href=\"/sparklemotion\" class=\"url fn\" rel=\"author\">sparklemotion</a></span><!--\n--><span class=\"path-divider\">/</span><!--\n--><strong itemprop=\"name\"><a href=\"/sparklemotion/nokogiri\" data-pjax=\"#js-repo-pjax-container\">nokogiri</a></strong>\n\n</h1>",
                    "content": "\n  \n  sparklemotion/nokogiri\n\n",
                    "href": null
                }
            },
            {
                "stored_element": {
                    "id": 2,
                    "tag": "h1",
                    "html": "<h1>\n<a href=\"#nokogiri\" aria-hidden=\"true\" class=\"anchor\" id=\"user-content-nokogiri\"><svg aria-hidden=\"true\" class=\"octicon octicon-link\" height=\"16\" version=\"1.1\" viewbox=\"0 0 16 16\" width=\"16\"><path fill-rule=\"evenodd\" d=\"M4 9h1v1H4c-1.5 0-3-1.69-3-3.5S2.55 3 4 3h4c1.45 0 3 1.69 3 3.5 0 1.41-.91 2.72-2 3.25V8.59c.58-.45 1-1.27 1-2.09C10 5.22 8.98 4 8 4H4c-.98 0-2 1.22-2 2.5S3 9 4 9zm9-3h-1v1h1c1 0 2 1.22 2 2.5S13.98 12 13 12H9c-.98 0-2-1.22-2-2.5 0-.83.42-1.64 1-2.09V6.25c-1.09.53-2 1.84-2 3.25C6 11.31 7.55 13 9 13h4c1.45 0 3-1.69 3-3.5S14.5 6 13 6z\"></path></svg></a>Nokogiri</h1>",
                    "content": "Nokogiri",
                    "href": null
                }
            }
        ],
        "stored_tags": [
            "h1"
        ]
    }
}
```


* `GET http://HOST_URL/api/v1/pages.json?id=STORED_URL`
  Return stored info from an URL.
#### Request

| Name        | Description           | Example  |
| ------------- |:-------------:| -----:|
| id      | Url you want to see | https://github.com/sparklemotion/nokogiri |

#### Response

| Name        | Description           |
| ------------- |:-------------:|
| id      | Database uniq identifier |
| url      | Url scanned |
| stored_tags      | array of indexed tags |
| stored_elements      | array of Elements for each tag |
| stored_elements[id]      |Element database uniq identifier |
| stored_elements[tag]      |Element html tag that belongs |
| stored_elements[html]      |Element string inside the html tag, this contains html code |
| stored_elements[content]      |Element string visible by users. This is the text that a normal user can see in the page|
| stored_elements[href]      |Element href url. Only for links (a)|

#### Example
##### Request example
`GET http://HOST_URL/api/v1/pages.json?id=https://github.com/sparklemotion/nokogiri`

params
```json
{ "id": "https://github.com/sparklemotion/nokogiri" }
```
##### Response example
```json
{
    "page": {
        "id": 1,
        "url": "https://github.com/sparklemotion/nokogiri",
        "stored_elements": [
            {
                "stored_element": {
                    "id": 1,
                    "tag": "h1",
                    "html": "<h1 class=\"public \">\n  <svg aria-hidden=\"true\" class=\"octicon octicon-repo\" height=\"16\" version=\"1.1\" viewbox=\"0 0 12 16\" width=\"12\"><path fill-rule=\"evenodd\" d=\"M4 9H3V8h1v1zm0-3H3v1h1V6zm0-2H3v1h1V4zm0-2H3v1h1V2zm8-1v12c0 .55-.45 1-1 1H6v2l-1.5-1.5L3 16v-2H1c-.55 0-1-.45-1-1V1c0-.55.45-1 1-1h10c.55 0 1 .45 1 1zm-1 10H1v2h2v-1h3v1h5v-2zm0-10H2v9h9V1z\"></path></svg>\n  <span class=\"author\" itemprop=\"author\"><a href=\"/sparklemotion\" class=\"url fn\" rel=\"author\">sparklemotion</a></span><!--\n--><span class=\"path-divider\">/</span><!--\n--><strong itemprop=\"name\"><a href=\"/sparklemotion/nokogiri\" data-pjax=\"#js-repo-pjax-container\">nokogiri</a></strong>\n\n</h1>",
                    "content": "\n  \n  sparklemotion/nokogiri\n\n",
                    "href": null
                }
            },
            {
                "stored_element": {
                    "id": 2,
                    "tag": "h1",
                    "html": "<h1>\n<a href=\"#nokogiri\" aria-hidden=\"true\" class=\"anchor\" id=\"user-content-nokogiri\"><svg aria-hidden=\"true\" class=\"octicon octicon-link\" height=\"16\" version=\"1.1\" viewbox=\"0 0 16 16\" width=\"16\"><path fill-rule=\"evenodd\" d=\"M4 9h1v1H4c-1.5 0-3-1.69-3-3.5S2.55 3 4 3h4c1.45 0 3 1.69 3 3.5 0 1.41-.91 2.72-2 3.25V8.59c.58-.45 1-1.27 1-2.09C10 5.22 8.98 4 8 4H4c-.98 0-2 1.22-2 2.5S3 9 4 9zm9-3h-1v1h1c1 0 2 1.22 2 2.5S13.98 12 13 12H9c-.98 0-2-1.22-2-2.5 0-.83.42-1.64 1-2.09V6.25c-1.09.53-2 1.84-2 3.25C6 11.31 7.55 13 9 13h4c1.45 0 3-1.69 3-3.5S14.5 6 13 6z\"></path></svg></a>Nokogiri</h1>",
                    "content": "Nokogiri",
                    "href": null
                }
            }
        ],
        "stored_tags": [
            "h1"
        ]
    }
}
```


### Credits

* [Carlos Torres](https://github.com/katorres02) author
* [Nokogiri Gem](https://github.com/sparklemotion/nokogiri)

### License

Apache License
Version 2.0, January 2004
http://www.apache.org/licenses/


