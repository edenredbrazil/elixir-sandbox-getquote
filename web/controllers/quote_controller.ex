defmodule ApiExample.QuoteController do
	use ApiExample.Web, :controller

	import SweetXml

	def index(conn, params) do
		wsdl = "http://www.webservicex.com/stockquote.asmx?WSDL"
		method = "GetQuote"

		symbol =
			case params["symbol"] do
				nil -> ""
				c -> c
			end
		
		IO.puts "symbol: #{symbol}"

		parameters = [symbol]
		response = Detergentex.call(wsdl, method, parameters)

		IO.inspect response

		data = to_string elem(Enum.at(elem(response, 2), 0), 2)
		
		unless data == "exception" do
			high = parse(data) |> xpath(~x[//High/text()]s)

			if high == "N/A" do
				conn
				|> put_status(404)
				|> json(%{message: "#{symbol} not found"})
			end

			resp_obj = parse(data)
			|> xmap(
				symbol: ~x[//Symbol/text()]s,
				name: ~x[//Name/text()]s,
				high: ~x[//High/text()]f,
				low: ~x[//Low/text()]f)
			
			conn
			|> put_status(200) 
			|> json(resp_obj)
		end

		conn
		|> put_status(400)
		|> json(%{message: "Bad request: you must query 'symbol'"})
  end
end