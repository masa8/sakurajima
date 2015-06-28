# encoding: utf-8
require "sparql/client"

class SakurajimaDataProvider

def initialize() 
 @last_erupted_date = nil
end

def erupted? ()
 client = SPARQL::Client.new("http://api.aitc.jp/ds/sparql")
 results = client.query(%(
  PREFIX atom:  <http://www.w3.org/2005/Atom#>
  PREFIX jma:   <http://cloud.projectla.jp/jma/>

  SELECT  ?content  
  WHERE {?id atom:title "噴火に関する火山観測報" . 
  ?id atom:updated ?updated . 
  ?id atom:content ?content . 
  ?id atom:link ?link} 

  ORDER BY DESC(?updated)
  LIMIT 1
 ))

 results.each do |solution|
    
    if solution[:content].to_s.include? "火　　山：桜島"
     solution[:content].to_s.each_line { | line |
     if md = line.match(/^日　　時：(\d*年\s*\d*月\s*\d*日\s*\d*時\s*\d*分).*/)
       if @last_erupted_date != md[1]
         @last_erupted_date = md[1]
         puts @last_erupted_date
         return true
       end
     end
     }
    end #if
 end #each
 false
end #erupted?
end # class
