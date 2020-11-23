# Tomato downloader 

This is a simple tool which lets you remove watermarks from images you find on websites such as _Shutterstuck_ or _gettyimages_. This will be available as a ruby gem soon. 

## Methods 

### TomatoDownloader 

_TODO_ 

### GettyImages 

* __Getting a list of links for a first page of the search__:

```ruby
tomato = Tomato::GettyImages.new("tomato")  
tomato = tomato.get_links #=> will return an array of links
``` 

* __Getting a list of links for further pages of the search__: 

```ruby
tomato = Tomato::GettyImages.new("tomato", page_number) #=> page number must be greater than 1
tomato = tomato.get_links 
```