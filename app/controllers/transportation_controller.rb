require 'uri'

class TransportationController < ApplicationController  
  def connection
    from = params.require(:from)
    to = params.require(:to)
    dateAtArrival = params.require(:dateToArrival)
    timeAtArrival = params.require(:timeAtArrival)  
    
    begin
      from_geocoordinates = get_geocoordinates(from)
      to_geocoordinates = get_geocoordinates(to)
      from = get_location(from_geocoordinates)[0]
      to = get_location(to_geocoordinates)[0]
    rescue RestClient::Exception => e
      puts e
    end
    
    puts(from);
    puts(to);
    
    begin
      connection = Transprt.connections :from => URI.escape(from["name"]), :to => URI.escape(to["name"]), :isArrivalTime => 1, :date => dateAtArrival, :time => timeAtArrival
    rescue Exception => e
      puts e
    end
    
    if(!connection.nil? && !connection[0].nil?)
      puts connection
      connection = connection[0]
      connection["from"]["departure"] = DateTime.parse(connection["from"]["departure"]).strftime("%d %b %Y, %H:%M");
      connection["to"]["arrival"] = DateTime.parse(connection["to"]["arrival"]).strftime("%d %b %Y, %H:%M");
    else 
      connection = nil
    end

    render :json => connection
  end
end

def get_geocoordinates(address) 
 puts(address)
 return JSON.parse(RestClient.get "https://maps.googleapis.com/maps/api/geocode/json?address="+URI.escape(address))
end

def get_location(geocoordinates) 
  location = geocoordinates["results"][0]["geometry"]["location"]
  return Transprt.locations :x => location["lat"], :y => location["lng"]
end
