# Teste API para Stock Symbol Quote

Teste com Phoenix (Elixir) para servir uma API REST trazendo cotação da bolsa via SOAP de http://www.webservicex.com/stockquote.asmx?WSDL

exemplo de chamada para a API

```curl -v -XGET http://localhost:4000/api/v1/quote?symbol=GOOGL```

To start your Phoenix app:

  * Install dependencies with `mix deps.get`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix