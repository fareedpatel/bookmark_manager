require 'data_mapper'


class Tag

	include DataMapper::Resource

	 has n, :links, through: Resource

property :id,      Serial
property :tag,     Text	


end