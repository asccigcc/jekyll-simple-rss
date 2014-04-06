# A Liquid tag for Jekyll sites that allows read Rss feed
# using simple-rss.
# @link: https://github.com/cardmagic/simple-rss
#
# Version 0.0.1
# Author: Pastorinni Ochoa
# @AUTHOR ascci.gcc@gmail.com @momiaalpastor
# Source URL: https://github.com/asccigcc/jekyll-simple-rss

# Example usage:
#   {% simple_rss http://slashdot.org/index.rdf %}
#
# Documentation:
#   https://github.com/asccigcc/jekyll-simple-rss/blob/master/README.md
#

require 'rubygems'
require 'simple-rss'
require 'open-uri'

module Jekyll
 class SimpleRssTag < Liquid::Tag
    def initialize(tag_name, text, tokens)
      super
      @text = text
    end

    def render(context)      
      body = 'Not items in my blog'
      rss = SimpleRSS.parse open(@text)            
      if rss.items.count
       body = ''
       rss.items.each do |item|         
         body += item_list_for item
       end
      end     
      html_output_for body
    end

    private

    def item_list_for item
     "<li><a href='#{item.link}'>#{item.title}</a></li>"
    end

    def html_output_for body 
      "<ul>#{body}</ul>"
    end
    
 end    
end

Liquid::Template.register_tag('simple_rss', Jekyll::SimpleRssTag)