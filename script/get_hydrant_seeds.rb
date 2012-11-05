require "net/http"
require "uri"
require 'JSON'
require 'pp'

id = 1
file = "./db/seeds.rb"
response = Net::HTTP.get_response(URI.parse("http://arcgis.awwu.biz/ArcGIS/rest/services/ExternalHydrants/MapServer/1/query?text=&geometry=&geometryType=esriGeometryPoint&inSR=&spatialRel=esriSpatialRelIntersects&relationParam=&objectIds=&where=1%3D1&time=&returnCountOnly=false&returnIdsOnly=false&returnGeometry=true&maxAllowableOffset=&outSR=4326&outFields=&f=pjson"))
data = JSON.parse(response.body)
geometry = data["geometryType"]
puts geometry
sr = data["spatialReference"]
puts sr
hydrants = data["features"]
begin
  seed_file = File.open(file, 'a')
  hydrants.each do |hydrant|
    geometry=hydrant["geometry"]
    seed_file.puts "Thing.create(city_id:#{id}, lng:#{geometry['x']}, lat:#{geometry['y']})"
    id += 1
  end
ensure
  seed_file.close unless seed_file == nil
end

