defmodule ApiExample.GeoController do
	use ApiExample.Web, :controller

	import SweetXml

	def index(conn, params) do
        ip = params["ip"]

        url = "http://ws.cdyne.com/ip2geo/ip2geo.asmx"
        headers = [
            {"Content-Type", "application/soap+xml;charset=UTF-8;action=\"http://ws.cdyne.com/ResolveIP\""}
        ]

        soap_body = """
<soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:ws="http://ws.cdyne.com/">
   <soap:Header/>
   <soap:Body>
      <ws:ResolveIP>
         <ws:ipAddress>#{ip}</ws:ipAddress>
         <ws:licenseKey>xpto</ws:licenseKey>
      </ws:ResolveIP>
   </soap:Body>
</soap:Envelope>
    """
        
        status = 200
        resp_obj = %{dummy: ""}

        case HTTPoison.post url, soap_body, headers do
            {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
                resp_obj = parse(body)
                |> xmap(
                    city: ~x[//City/text()]s,
                    country: ~x[//Country/text()]s,
                    message: ~x[//Organization/text()]s)
                status = 200
                IO.puts body
            {:ok, %HTTPoison.Response{status_code: 500, body: body}} ->
                resp_obj = parse(body)
                |> xmap(message: ~x[//soap:Reason/soap:Text/text()]s)
                
                status = 500
                IO.puts body
            _ ->
                status = 500
        end

        conn
        |> put_status(status)
        |> json(resp_obj)
  end
end