require 'rest-client'
require 'json'

class Population
	attr_accessor :country_url

## Setup the list of countries and the base URL that the data will be pulled from.  I didn't type this list out manually.  I pulled it from a table on quandl.com and then concatenated commas and quotation marks to the list using Excel 
	def base_url
		"http://www.quandl.com/api/v1/datasets/WORLDBANK/"
	end	
	def countries
		{'Afghanistan' => 'AFG','Angola' => 'AGO','Albania' => 'ALB','UAE' => 'ARE','Argentina' => 'ARG','Armenia' => 'ARM','Antigua And Barbuda' => 'ATG','Australia' => 'AUS','Austria' => 'AUT','Azerbaijan' => 'AZE','Burundi' => 'BDI','Belgium' => 'BEL','Benin' => 'BEN','Burkina Faso' => 'BFA','Bangladesh' => 'BGD','Bulgaria' => 'BGR','Bahrain' => 'BHR','The Bahamas' => 'BHS','Bosnia And Herzegovina' => 'BIH','Belarus' => 'BLR','Belize' => 'BLZ','Bolivia' => 'BOL','Brazil' => 'BRA','Barbados' => 'BRB','Brunei' => 'BRN','Bhutan' => 'BTN','Botswana' => 'BWA','Central African Republic' => 'CAF','Canada' => 'CAN','Switzerland' => 'CHE','Chile' => 'CHL','China' => 'CHN','Ivory Coast' => 'CIV','Cameroon' => 'CMR','Congo' => 'COD','Congo-Brazzaville' => 'COG','Colombia' => 'COL','Comoros' => 'COM','Cape Verde' => 'CPV','Costa Rica' => 'CRI','Cuba' => 'CUB','Cyprus' => 'CYP','Czech Republic' => 'CZE','Germany' => 'DEU','Djibouti' => 'DJI','Dominica' => 'DMA','Denmark' => 'DNK','Dominican Republic' => 'DOM','Algeria' => 'DZA','Ecuador' => 'ECU','Egypt' => 'EGY','Eritrea' => 'ERI','Spain' => 'ESP','Estonia' => 'EST','Ethiopia' => 'ETH','Finland' => 'FIN','Fiji' => 'FJI','France' => 'FRA','Gabon' => 'GAB','UK' => 'GBR','Georgia' => 'GEO','Ghana' => 'GHA','Guinea' => 'GIN','Gambia' => 'GMB','Guinea-Bissau' => 'GNB','Equatorial Guinea' => 'GNQ','Greece' => 'GRC','Grenada' => 'GRD','Guatemala' => 'GTM','Guyana' => 'GUY','Hong Kong' => 'HKG','Honduras' => 'HND','Croatia' => 'HRV','Haiti' => 'HTI','Hungary' => 'HUN','Indonesia' => 'IDN','India' => 'IND','Ireland' => 'IRL','Iran' => 'IRN','Iraq' => 'IRQ','Iceland' => 'ISL','Israel' => 'ISR','Italy' => 'ITA','Jamaica' => 'JAM','Jordan' => 'JOR','Japan' => 'JPN','Kazakhstan' => 'KAZ','Kenya' => 'KEN','Kyrgyzstan' => 'KGZ','Cambodia' => 'KHM','Kiribati' => 'KIR','Saint Kitts And Nevis' => 'KNA','South Korea' => 'KOR','Kosovo' => 'KSV','Kuwait' => 'KWT','Laos' => 'LAO','Lebanon' => 'LBN','Liberia' => 'LBR','Libya' => 'LBY','Saint Lucia' => 'LCA','Sri Lanka' => 'LKA','Lesotho' => 'LSO','Lithuania' => 'LTU','Luxembourg' => 'LUX','Latvia' => 'LVA','Morocco' => 'MAR','Moldova' => 'MDA','Madagascar' => 'MDG','Maldives' => 'MDV','Mexico' => 'MEX','Macedonia' => 'MKD','Mali' => 'MLI','Malta' => 'MLT','Myanmar' => 'MMR','Montenegro' => 'MNE','Mongolia' => 'MNG','Mozambique' => 'MOZ','Mauritania' => 'MRT','Mauritius' => 'MUS','Malawi' => 'MWI','Malaysia' => 'MYS','Namibia' => 'NAM','Niger' => 'NER','Nigeria' => 'NGA','Nicaragua' => 'NIC','Netherlands' => 'NLD','Norway' => 'NOR','Nepal' => 'NPL','New Zealand' => 'NZL','Oman' => 'OMN','Pakistan' => 'PAK','Panama' => 'PAN','Peru' => 'PER','Philippines' => 'PHL','Papua New Guinea' => 'PNG','Poland' => 'POL','North Korea' => 'PRK','Portugal' => 'PRT','Paraguay' => 'PRY','Qatar' => 'QAT','Romania' => 'ROU','Russia' => 'RUS','Rwanda' => 'RWA','Saudi Arabia' => 'SAU','Sudan' => 'SDN','Senegal' => 'SEN','Singapore' => 'SGP','Solomon Islands' => 'SLB','Sierra Leone' => 'SLE','El Salvador' => 'SLV','San Marino' => 'SMR','Somalia' => 'SOM','Serbia' => 'SRB','South Sudan' => 'SSD','Sao Tome And Principe' => 'STP','Suriname' => 'SUR','Slovak Republic' => 'SVK','Slovenia' => 'SVN','Sweden' => 'SWE','Swaziland' => 'SWZ','Seychelles' => 'SYC','Syria' => 'SYR','Chad' => 'TCD','Togo' => 'TGO','Thailand' => 'THA','Tajikistan' => 'TJK','Turkmenistan' => 'TKM','Timor-Leste' => 'TLS','Tonga' => 'TON','Trinidad And Tobago' => 'TTO','Tunisia' => 'TUN','Turkey' => 'TUR','Tuvalu' => 'TUV','Tanzania' => 'TZA','Uganda' => 'UGA','Ukraine' => 'UKR','Uruguay' => 'URY','United States' => 'USA','Uzbekistan' => 'UZB','Saint Vincent And The Grenadines' => 'VCT','Venezuela' => 'VEN','Vietnam' => 'VNM','Vanuatu' => 'VUT','Samoa' => 'WSM','Yemen' => 'YEM','South Africa' => 'ZAF','Zambia' => 'ZMB','Zimbabwe' => 'ZWE'}
	end
	
	##Initialize the class, and sets up the URL for the API depending on the user input
	def initialize(key)
		@country_url = "#{base_url}#{countries[key]}_SP_POP_TOTL?format=json"
	end

## checks that the user has inputted a country, otherwise the program exits
def sanitize(input)
	if countries.has_key?(input) == false
		puts "That's not a country.  Did you take Geography? Check the spelling of the country, or try something else"
		exit
	end
end

## Gets the data from the API
def get
	response = RestClient.get(country_url)
	@parsed_response = JSON.parse(response)
end

## Puts commas in the number returned to make it more legible
def comma_numbers(number, delimiter = ',')
  number.to_s.reverse.gsub(%r{([0-9]{3}(?=([0-9])))}, "\\1#{delimiter}").reverse
end

## calls the population number from the retrieved API
def population
	response = @parsed_response['data'][0][1].to_i
	comma_numbers(response)
end
end


